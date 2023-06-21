CREATE TASK dbt_task
  WAREHOUSE = compute_wh
  SCHEDULE = 'USING CRON 0 8 * * * America/Sao_Paulo'
AS
  CALL system$run_integration('dbt_integration', 'run', 'full-refresh');
