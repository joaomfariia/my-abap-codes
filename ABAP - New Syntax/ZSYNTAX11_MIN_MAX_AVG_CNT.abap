*&---------------------------------------------------------------------*
*& Report ZSYNTAX11_MIN_MAX_AVG_CNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyntax11_min_max_avg_cnt.

SELECT vbeln, MAX( netwr ) AS max_netwr,
              MIN( netwr ) AS min_netwr,
              COUNT( netwr ) AS count_netwr,
              SUM( netwr ) AS sum_netwr
FROM vbap
WHERE vbeln BETWEEN '0000000001' AND '9000000000'
GROUP BY vbeln, posnr
INTO TABLE @DATA(it_vbap).

cl_demo_output=>display( it_vbap ).