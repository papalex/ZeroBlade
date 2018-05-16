ALTER TABLE public.krp_company ADD company_id bigint /*NOT NULL*/;
/*ALTER TABLE public.krp_company
  ADD CONSTRAINT "krp_company > company"
FOREIGN KEY (company_id) REFERENCES company (company_id);*/