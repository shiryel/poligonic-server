--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cannons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cannons (
    id bigint NOT NULL,
    damage integer NOT NULL,
    hitbox bigint
);


--
-- Name: cannons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cannons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cannons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cannons_id_seq OWNED BY public.cannons.id;


--
-- Name: hitboxs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hitboxs (
    id bigint NOT NULL,
    colison_route jsonb NOT NULL,
    life integer NOT NULL,
    godmode boolean NOT NULL,
    poligon bigint
);


--
-- Name: hitboxs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hitboxs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hitboxs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hitboxs_id_seq OWNED BY public.hitboxs.id;


--
-- Name: poligon_structs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.poligon_structs (
    id bigint NOT NULL,
    route jsonb NOT NULL,
    color jsonb NOT NULL,
    floor integer NOT NULL,
    poligon bigint
);


--
-- Name: poligon_structs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.poligon_structs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: poligon_structs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.poligon_structs_id_seq OWNED BY public.poligon_structs.id;


--
-- Name: poligons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.poligons (
    id bigint NOT NULL,
    name character varying(255),
    floor integer NOT NULL,
    "user" bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: poligons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.poligons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: poligons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.poligons_id_seq OWNED BY public.poligons.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255),
    email character varying(255),
    password_hash character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: cannons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cannons ALTER COLUMN id SET DEFAULT nextval('public.cannons_id_seq'::regclass);


--
-- Name: hitboxs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hitboxs ALTER COLUMN id SET DEFAULT nextval('public.hitboxs_id_seq'::regclass);


--
-- Name: poligon_structs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poligon_structs ALTER COLUMN id SET DEFAULT nextval('public.poligon_structs_id_seq'::regclass);


--
-- Name: poligons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poligons ALTER COLUMN id SET DEFAULT nextval('public.poligons_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: cannons cannons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cannons
    ADD CONSTRAINT cannons_pkey PRIMARY KEY (id);


--
-- Name: hitboxs hitboxs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hitboxs
    ADD CONSTRAINT hitboxs_pkey PRIMARY KEY (id);


--
-- Name: poligon_structs poligon_structs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poligon_structs
    ADD CONSTRAINT poligon_structs_pkey PRIMARY KEY (id);


--
-- Name: poligons poligons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poligons
    ADD CONSTRAINT poligons_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_username_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_username_index ON public.users USING btree (username);


--
-- Name: cannons cannons_hitbox_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cannons
    ADD CONSTRAINT cannons_hitbox_fkey FOREIGN KEY (hitbox) REFERENCES public.hitboxs(id) ON DELETE CASCADE;


--
-- Name: hitboxs hitboxs_poligon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hitboxs
    ADD CONSTRAINT hitboxs_poligon_fkey FOREIGN KEY (poligon) REFERENCES public.poligons(id) ON DELETE CASCADE;


--
-- Name: poligon_structs poligon_structs_poligon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poligon_structs
    ADD CONSTRAINT poligon_structs_poligon_fkey FOREIGN KEY (poligon) REFERENCES public.poligons(id) ON DELETE CASCADE;


--
-- Name: poligons poligons_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poligons
    ADD CONSTRAINT poligons_user_fkey FOREIGN KEY ("user") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20190324160029);

