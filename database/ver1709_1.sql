--
-- PostgreSQL database dump
--

\restrict A1dzZVRzfnrbXVdRyOGTRJl373aksLAe5xFwUszeazZbjIYpL5ugvssgQh76Vi7

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.4

-- Started on 2026-09-17 07:33:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 16497)
-- Name: tbl_digitization_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_digitization_queue (
    queue_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    document_id uuid NOT NULL,
    raw_ai_json jsonb NOT NULL,
    validation_status character varying(20) DEFAULT 'Pending'::character varying NOT NULL,
    operator_comments text,
    last_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_validation_status CHECK (((validation_status)::text = ANY ((ARRAY['Pending'::character varying, 'Flagged'::character varying, 'Approved'::character varying, 'Rejected'::character varying])::text[])))
);


ALTER TABLE public.tbl_digitization_queue OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16484)
-- Name: tbl_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_documents (
    document_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    file_url text NOT NULL,
    document_type character varying(50) NOT NULL,
    upload_timestamp timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_document_type CHECK (((document_type)::text = ANY ((ARRAY['Khasra'::character varying, 'Khatauni'::character varying, 'Cadastral Map'::character varying, 'Sale Deed'::character varying, 'Other'::character varying])::text[])))
);


ALTER TABLE public.tbl_documents OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16412)
-- Name: tbl_land_parcel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_land_parcel (
    parcel_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    survey_number character varying(50) NOT NULL,
    total_area numeric(10,4) NOT NULL,
    unit_of_measurement character varying(20) NOT NULL,
    village_code character varying(20) NOT NULL,
    land_type character varying(50) NOT NULL
);


ALTER TABLE public.tbl_land_parcel OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16424)
-- Name: tbl_owner_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_owner_entity (
    owner_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    full_name character varying(100) NOT NULL,
    fathers_name character varying(100),
    aadhar_hash character varying(64),
    contact_info character varying(255)
);


ALTER TABLE public.tbl_owner_entity OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16436)
-- Name: tbl_ownership_share; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_ownership_share (
    ownership_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    parcel_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    share_percentage numeric(5,2) NOT NULL,
    tenure_type character varying(50) NOT NULL
);


ALTER TABLE public.tbl_ownership_share OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16457)
-- Name: tbl_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_transactions (
    transaction_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    parcel_id uuid NOT NULL,
    seller_id uuid,
    buyer_id uuid NOT NULL,
    transaction_date date NOT NULL,
    sale_value numeric(15,2) NOT NULL,
    deed_type character varying(50) NOT NULL
);


ALTER TABLE public.tbl_transactions OWNER TO postgres;

--
-- TOC entry 5071 (class 0 OID 16497)
-- Dependencies: 225
-- Data for Name: tbl_digitization_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_digitization_queue (queue_id, document_id, raw_ai_json, validation_status, operator_comments, last_updated) FROM stdin;
\.


--
-- TOC entry 5070 (class 0 OID 16484)
-- Dependencies: 224
-- Data for Name: tbl_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_documents (document_id, file_url, document_type, upload_timestamp) FROM stdin;
\.


--
-- TOC entry 5066 (class 0 OID 16412)
-- Dependencies: 220
-- Data for Name: tbl_land_parcel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_land_parcel (parcel_id, survey_number, total_area, unit_of_measurement, village_code, land_type) FROM stdin;
\.


--
-- TOC entry 5067 (class 0 OID 16424)
-- Dependencies: 221
-- Data for Name: tbl_owner_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_owner_entity (owner_id, full_name, fathers_name, aadhar_hash, contact_info) FROM stdin;
\.


--
-- TOC entry 5068 (class 0 OID 16436)
-- Dependencies: 222
-- Data for Name: tbl_ownership_share; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_ownership_share (ownership_id, parcel_id, owner_id, share_percentage, tenure_type) FROM stdin;
\.


--
-- TOC entry 5069 (class 0 OID 16457)
-- Dependencies: 223
-- Data for Name: tbl_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_transactions (transaction_id, parcel_id, seller_id, buyer_id, transaction_date, sale_value, deed_type) FROM stdin;
\.


--
-- TOC entry 4912 (class 2606 OID 16511)
-- Name: tbl_digitization_queue tbl_digitization_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_digitization_queue
    ADD CONSTRAINT tbl_digitization_queue_pkey PRIMARY KEY (queue_id);


--
-- TOC entry 4908 (class 2606 OID 16496)
-- Name: tbl_documents tbl_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_documents
    ADD CONSTRAINT tbl_documents_pkey PRIMARY KEY (document_id);


--
-- TOC entry 4898 (class 2606 OID 16423)
-- Name: tbl_land_parcel tbl_land_parcel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_land_parcel
    ADD CONSTRAINT tbl_land_parcel_pkey PRIMARY KEY (parcel_id);


--
-- TOC entry 4900 (class 2606 OID 16435)
-- Name: tbl_owner_entity tbl_owner_entity_aadhar_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_owner_entity
    ADD CONSTRAINT tbl_owner_entity_aadhar_hash_key UNIQUE (aadhar_hash);


--
-- TOC entry 4902 (class 2606 OID 16433)
-- Name: tbl_owner_entity tbl_owner_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_owner_entity
    ADD CONSTRAINT tbl_owner_entity_pkey PRIMARY KEY (owner_id);


--
-- TOC entry 4904 (class 2606 OID 16446)
-- Name: tbl_ownership_share tbl_ownership_share_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_ownership_share
    ADD CONSTRAINT tbl_ownership_share_pkey PRIMARY KEY (ownership_id);


--
-- TOC entry 4906 (class 2606 OID 16468)
-- Name: tbl_transactions tbl_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_transactions
    ADD CONSTRAINT tbl_transactions_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 4909 (class 1259 OID 16517)
-- Name: idx_ai_json_data; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_json_data ON public.tbl_digitization_queue USING gin (raw_ai_json);


--
-- TOC entry 4910 (class 1259 OID 16518)
-- Name: idx_validation_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_validation_status ON public.tbl_digitization_queue USING btree (validation_status);


--
-- TOC entry 4918 (class 2606 OID 16512)
-- Name: tbl_digitization_queue tbl_digitization_queue_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_digitization_queue
    ADD CONSTRAINT tbl_digitization_queue_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.tbl_documents(document_id) ON DELETE CASCADE;


--
-- TOC entry 4913 (class 2606 OID 16452)
-- Name: tbl_ownership_share tbl_ownership_share_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_ownership_share
    ADD CONSTRAINT tbl_ownership_share_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.tbl_owner_entity(owner_id) ON DELETE CASCADE;


--
-- TOC entry 4914 (class 2606 OID 16447)
-- Name: tbl_ownership_share tbl_ownership_share_parcel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_ownership_share
    ADD CONSTRAINT tbl_ownership_share_parcel_id_fkey FOREIGN KEY (parcel_id) REFERENCES public.tbl_land_parcel(parcel_id) ON DELETE CASCADE;


--
-- TOC entry 4915 (class 2606 OID 16479)
-- Name: tbl_transactions tbl_transactions_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_transactions
    ADD CONSTRAINT tbl_transactions_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.tbl_owner_entity(owner_id) ON DELETE CASCADE;


--
-- TOC entry 4916 (class 2606 OID 16469)
-- Name: tbl_transactions tbl_transactions_parcel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_transactions
    ADD CONSTRAINT tbl_transactions_parcel_id_fkey FOREIGN KEY (parcel_id) REFERENCES public.tbl_land_parcel(parcel_id) ON DELETE CASCADE;


--
-- TOC entry 4917 (class 2606 OID 16474)
-- Name: tbl_transactions tbl_transactions_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_transactions
    ADD CONSTRAINT tbl_transactions_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.tbl_owner_entity(owner_id) ON DELETE SET NULL;


-- Completed on 2026-09-17 07:33:34

--
-- PostgreSQL database dump complete
--

\unrestrict A1dzZVRzfnrbXVdRyOGTRJl373aksLAe5xFwUszeazZbjIYpL5ugvssgQh76Vi7

