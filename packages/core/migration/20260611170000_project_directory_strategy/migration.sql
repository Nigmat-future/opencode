CREATE TABLE `__new_project_directory` (
	`project_id` text NOT NULL,
	`directory` text NOT NULL,
	`strategy` text,
	`time_created` integer NOT NULL,
	CONSTRAINT `project_directory_pk` PRIMARY KEY(`project_id`, `directory`),
	CONSTRAINT `fk_project_directory_project_id_project_id_fk` FOREIGN KEY (`project_id`) REFERENCES `project`(`id`) ON DELETE CASCADE
);
--> statement-breakpoint
INSERT INTO `__new_project_directory` (`project_id`, `directory`, `strategy`, `time_created`)
SELECT `project_id`, `directory`, CASE WHEN `type` IN ('main', 'root') THEN NULL ELSE `type` END, `time_created`
FROM `project_directory`;
--> statement-breakpoint
INSERT OR IGNORE INTO `__new_project_directory` (`project_id`, `directory`, `strategy`, `time_created`)
SELECT `id`, `worktree`, NULL, `time_created`
FROM `project`
WHERE `id` <> 'global';
--> statement-breakpoint
DROP TABLE `project_directory`;
--> statement-breakpoint
ALTER TABLE `__new_project_directory` RENAME TO `project_directory`;
