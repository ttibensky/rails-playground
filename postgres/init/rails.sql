--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: rails
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO rails;

--
-- Name: listings; Type: TABLE; Schema: public; Owner: rails
--

CREATE TABLE public.listings (
    id bigint NOT NULL,
    title character varying,
    url character varying NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.listings OWNER TO rails;

--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: rails
--

CREATE SEQUENCE public.listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listings_id_seq OWNER TO rails;

--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rails
--

ALTER SEQUENCE public.listings_id_seq OWNED BY public.listings.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: rails
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    text character varying,
    stars integer NOT NULL,
    author character varying NOT NULL,
    listing_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO rails;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: rails
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO rails;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rails
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: rails
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO rails;

--
-- Name: users; Type: TABLE; Schema: public; Owner: rails
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone
);


ALTER TABLE public.users OWNER TO rails;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: rails
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO rails;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rails
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.listings ALTER COLUMN id SET DEFAULT nextval('public.listings_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: rails
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-01-06 10:25:33.10193	2024-01-06 10:25:33.101933
\.


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: rails
--

COPY public.listings (id, title, url, user_id, created_at, updated_at) FROM stdin;
1	🚙 Private Garage 🏙 Center City Roofdeck w 🔥Hot Tub	https://www.airbnb.com/h/roofdeckhottub	2	2024-01-06 13:13:22.319715	2024-01-06 13:13:22.319715
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: rails
--

COPY public.reviews (id, text, stars, author, listing_id, created_at, updated_at) FROM stdin;
1	to improve the cleanliness,	3	Andrea Carolina	1	2024-01-06 13:13:22.33106	2024-01-06 13:13:22.33106
2	Cory’s place is fantastic. The location is central to everything. Walkable to many restaurants and a very short drive from literally anything we wanted to do. The house itself is great. Tons of space and very comfortable. Our kids loved the oversized bunk beds. The roof deck is awesome and the hot tub is superb. Cory himself was a fabulous host, responding *immediately* whenever we had a question, and providing great reccos for local places to eat that we truly enjoyed. We would love to stay again and will recommend to our friends as well.	5	Andy	1	2024-01-06 13:13:22.334465	2024-01-06 13:13:22.334465
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: rails
--

COPY public.schema_migrations (version) FROM stdin;
20240106092335
20240106103639
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: rails
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at) FROM stdin;
2	john.doe@example.com	$2a$12$r7Ldm.fKylMExpjsgDewOurWZBUkBfbthtYZPjGhC0B6RKTDlIIQu	\N	\N	\N
\.


--
-- Name: listings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rails
--

SELECT pg_catalog.setval('public.listings_id_seq', 1, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rails
--

SELECT pg_catalog.setval('public.reviews_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rails
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: rails
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: rails
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: reviews fk_rails_60def33a58; Type: FK CONSTRAINT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_60def33a58 FOREIGN KEY (listing_id) REFERENCES public.listings(id);


--
-- Name: listings fk_rails_baa008bfd2; Type: FK CONSTRAINT; Schema: public; Owner: rails
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT fk_rails_baa008bfd2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

