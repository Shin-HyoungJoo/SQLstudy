-- 한줄 주석 우다다다닷

/*
	여러줄 주석
*/

SELECT NOW() FROM DUAL;

/*
	char - 고정길이 (최대값 255)
	varchar - 가변길이 (최대값 65535)
	* mysql은 text(가변길이)(65535)
	심화--
	mediumtext(16777215)
	lontext(더많음)
*/

SHOW CHARACTER SET;

/*
	tinyint
	부호가 있는 -128 ~ 127
	부호가 없는 0 ~ 255
	 
	timestamp = 흐른시간저장
	(국제적 서비스 시 사용{시차때문})
	 
	datetime = 현재시간저장
	(국내 서비스 시 사용)
	
	
*/
