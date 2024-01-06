const express = require("express");
const app = express();
const port = 3000;
const puppeteer = require("puppeteer");
const bodyParser = require("body-parser");
const fs = require("fs");

app.use(bodyParser.json({ limit: "50mb" }));

let page;
const getPage = async () => {
  if (page) return page;

  const browser = await puppeteer.launch({
    executablePath: "/usr/bin/google-chrome",
    headless: true,
    args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-gpu",
      "--hide-scrollbars",
      "--disable-web-security",
      "--allow-file-access-from-files",
      "--enable-local-file-accesses",
    ],
  });

  page = await browser.newPage();

  await page.setViewport({ width: 1800, height: 1500 });

  // uncomment for debug purposes
  // page.on("console", (message) => console.log(`${message.type().substr(0, 3).toUpperCase()} ${message.text()}`))
  //     .on("pageerror", ({ message }) => console.log(message))
  //     .on("response", (response) => console.log(`response: ${response.status()} ${response.url()}`))
  //     .on("requestfailed", (request) => console.log(`requestfailed: ${request.failure().errorText} ${request.url()}`));

  return page;
};

/**
 * example response:
 * 
 * [
 *   {
 *      "author":"Andrea Carolina",
 *      "text":"to improve the cleanliness,",
 *      "stars":"3",
 *      "date":"2 days ago"
 *   },
 *   {
 *      "author":"Andy",
 *      "text":"Cory’s place is fantastic.",
 *      "stars":"5",
 *      "date":"1 week ago"
 *   }
 * ]
 */
app.post("/reviews/airbnb", async (req, res) => {
  try {
    const page = await getPage();

    // open page and wait until everything is loaded
    await page.goto(req.body?.url, { waitUntil: "domcontentloaded" });
    await page.waitForNavigation({ waitUntil: "networkidle0" });

    // prevent translation modal popping up
    await page.evaluate(() => {
      localStorage.setItem(
        "__amplify__translation_engine/TRANSLATION_ANNOUNCEMENT",
        { data: { pdp: 1704551955160 }, expires: null }
      );
    });

    // open page and wait until everything is loaded
    await page.goto(req.body?.url, { waitUntil: "domcontentloaded" });
    await page.waitForNavigation({ waitUntil: "networkidle0" });

    // click on Reviews link
    await page.evaluate(() => {
      for (const a of document.querySelectorAll("a")) {
        if (a.textContent.includes("Reviews")) {
          a.click();
        }
      }
    });
    await page.waitForTimeout(1000);

    // uncomment for debug purposes
    // await page.screenshot({ path: "test.png" });

    // extract reviews data
    // @TODO there is an infinite scroll, we need to scroll to the very bottom to get all the reviews
    // @TODO ignore reviews that we already have
    const authors = await page.$$eval(
      "[data-review-id] > div:nth-child(1) h3",
      (elements) => {
        return elements.map((e) => e.textContent);
      }
    );
    const texts = await page.$$eval(
      "[data-review-id] > div:nth-child(2) > div > div > span > span",
      (elements) => {
        return elements.map((e) => e.textContent);
      }
    );
    const dates = await page.$$eval(
      "[data-review-id] > div:nth-child(1) > div:nth-child(2)",
      (elements) => {
        return elements.map((e) =>
          e.textContent.split("·")[1].replace(/^[\s,]+|[\s,]+$/g, "")
        );
      }
    );
    const stars = await page.$$eval(
      "[data-review-id] > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > span:nth-child(1)",
      (elements) => {
        return elements.map((e) => e.textContent.match(/\d+/g)[0]);
      }
    );

    const reviews = [];
    for (let i = 0; i < authors.length; i++) {
      const review = {};
      review.author = authors[i];
      review.text = texts[i];
      review.stars = stars[i];
      review.date = dates[i];
      reviews.push(review);
    }

    return res.status(200).send(reviews);
  } catch (error) {
    if (typeof page !== "undefined" && page) {
      await page.close();
      page = null;
    }

    if (typeof browser !== "undefined" && browser) {
      await browser.close();
      browser = null;
    }

    return res.status(500).type("json").send({
      name: error.name,
      error: error.message,
      stack: error.stack,
    });
  }
});

app.listen(port, () => {
  console.log(`Crawler app listening on port ${port}`);
});
