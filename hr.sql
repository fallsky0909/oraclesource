-- employee 테이블 전체 내용 조회
-- employee 테이블 first_name, last_name, job_id 만 조회

SELECT
    *
FROM
    employees;

SELECT
    first_name 이름,
    last_name  성,
    job_id     직책
FROM
    employees;

-- 사원번호가 176인 사람의 LAST_NAME 조회
SELECT
    last_name
FROM
    employees
WHERE
    employee_id = 176;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary >= 12000;

-- 연봉이 5000 에서 12000 범위가 아닌 사람들의 LAST_NAEM, SALARY을 LAST_NAME의 내림차순으로 정리
SELECT
    *
FROM
    employees
WHERE
    5000 > salary
    OR 12000 < salary
ORDER BY
    last_name;

-- 20, 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME, 부서번호를 오름차순으로 조회
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    department_id,
    last_name;

-- 커미션을 받는 모든 사원들의 LAST_NAME, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
SELECT
    last_name,
    salary,
    commission_pct * salary
FROM
    employees
WHERE
    commission_pct > 0
ORDER BY
    salary DESC,
    commission_pct DESC;

-- 연봉이 2500, 3500, 7000이 아니며 직업이 SA_REP 나 ST_CLERK 인 사원 조회
SELECT
    *
FROM
    employees
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job_id NOT IN ( 'SA_REP', 'ST_CLERK' );
    
-- 2008/02/20~2008/05/01 사이에 고용된 사원들의 LAST_NAME,사번,고용일자 조회
-- 고용일자 내림차순 정렬
SELECT LAST_NAME, EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES WHERE '08-02-20' <= HIRE_DATE AND HIRE_DATE <= '08/05/01' ORDER BY HIRE_DATE DESC;

-- 2004년도에 고용된 사원들의 LAST_NAME, HIRE_DATE 조회
-- 고용일자 오름차순 정렬
SELECT LAST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE >= '04-01-01' AND HIRE_DATE <= '04-12-31' ORDER BY HIRE_DATE;

SELECT LAST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '04-01-01' AND '04-12-31' ORDER BY HIRE_DATE;

-- LIKE 

-- LAST_NAME 에 u가 포함된 사원들의 사번, last_name 조회
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%';

-- LAST_NAME 에 네번째 글자가 a인 사원들의 last_name 조회
SELECT LAST_NAME FROM EMPLOYEES WHERE LAST_NAME LIKE '___a%';

-- LAST_NAME에 a 혹은 e 글자가 포함된 사원들의 last_name 조회
-- LAST_NAME 오름차순 정렬
SELECT LAST_NAME FROM EMPLOYEES WHERE LAST_NAME LIKE '%a%' or LAST_NAME LIKE'%e%' ORDER BY LAST_NAME;

-- LAST_NAME에 a와 e 글자가 포함된 사원들의 last_name 조회
-- LAST_NAME 오름차순 정렬
SELECT LAST_NAME FROM EMPLOYEES WHERE LAST_NAME LIKE '%a%e%' or LAST_NAME LIKE'%e%a%' ORDER BY LAST_NAME;

-- 매니저(MANAGER_ID)가 없는 사람들의 LAST_NAME, JOB_ID 조회
SELECT LAST_NAME, JOB_ID FROM EMPLOYEES WHERE MANAGER_ID IS NULL or MANAGER_ID = '';

-- JOB_ID가 ST_CLERK 인 사원 조회(단 부서번호가 NULL 인 사원은 제외한다)
-- 중복을 제거한 후 부서번호만 조회 - DISTINCT(중복 제거)
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES WHERE JOB_ID='ST_CLERK' AND DEPARTMENT_ID IS NOT NULL;

-- COMMISSION_PCT NULL이 아닌 사원들 중에서 COMMISSION = SALARY*COMMISSION_PCT를 구하여
-- EMPLOYEE_ID, FIRST_NAME, JOB_ID 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY * COMMISSION_PCT COMMISSION FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;