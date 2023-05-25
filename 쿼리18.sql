CREATE TABLE t_board_cmt (
	icmt INT UNSIGNED AUTO_INCREMENT,
	iboard INT UNSIGNED NOT NULL,
	ctnt VARCHAR(300) NOT NULL,
	writer VARCHAR(10) NOT NULL,
	pw VARCHAR(10) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(icmt),
	FOREIGN KEY(iboard) REFERENCES t_board(iboard)
);

DROP TABLE t_board_cmt;

/*
	pk
	파일 경로
	업로더
	중요도
*/

CREATE TABLE t_file(
	ifile INT UNSIGNED AUTO_INCREMENT,
	path VARCHAR(200) NOT NULL,
	uploader VARCHAR(10) NOT NULL,
	level_value INT UNSIGNED NOT NULL,
	PRIMARY KEY (ifile)
);

