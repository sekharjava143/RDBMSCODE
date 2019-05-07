create database keepnote;
use keepnote;

create table note(
	note_id int not null auto_increment primary key, 
    note_title varchar(50) not null, 
    note_content text,
    note_status char(15) not null,
    note_creation_date datetime not null);
  
create table user (
	user_id int not null auto_increment primary key,
	user_name varchar(50) not null,
	user_added_date datetime not null,
	user_password varchar(50) not null,
	user_mobile char(15)
  );
  
create table category (
	category_id int not null auto_increment primary key,
    category_name char(20) not null,
    category_descr varchar(200),
    category_creation_date datetime not null,
    category_creator int not null,
    foreign key (category_creator) references user(user_id)
    );
    
create table reminder (
	reminder_id int not null auto_increment primary key,
    reminder_name varchar(50),
    reminder_descr varchar(200),
    reminder_type varchar(15) not null,
    reminder_creation_date datetime not null,
    reminder_creator int not null,
    foreign key (reminder_creator) references user(user_id)
);

create table usernote (
	usernote_id int not null auto_increment primary key,
    user_id int not null,
    note_id int not null,
    foreign key (user_id) references user(user_id),
    foreign key (note_id) references note(note_id)
);

create table notecategory (
	notecategory_id int not null auto_increment primary key,
    note_id int not null,
    category_id int not null,
    foreign key (note_id) references note(note_id),
    foreign key (category_id) references category(category_id)
);

create table notereminder (
	notereminder_id int not null auto_increment primary key,
    note_id int not null,
    reminder_id int not null,
    foreign key (note_id) references note(note_id),
    foreign key (reminder_id) references reminder(reminder_id)
);
    
select * from note;

insert into note(note_title, note_content, note_status, note_creation_date)
values('java ','session start at 10 AM', 'not-started',date(now())),
('Responsive web page','session in-progress ', 'started',date(now())),
('HTML','session completed', 'completed',date(now()));

insert into user(user_name, user_password, user_mobile, user_added_date)
values('Admin','password', '+91 8888888',date(now())),
('user','password', '+91 9777777777',date(now())),
('developer','password', '+91 9999888888',date(now()));

insert into category(category_name, category_descr, category_creator, category_creation_date)
values('Personal','group personal notes', 1,date(now())),
('Work','group work related notes', 1,date(now())),
('Inspiration','group inspirational notes', 1,date(now()));

insert into reminder(reminder_name, reminder_descr, reminder_type, reminder_creator, reminder_creation_date)
values(' RDBMS','RDBMS will start in next 1 hour','medium', 1,date(now())),
('RDBMS','RDBMS yet be completed','high', 1,date(now()));

select * from note;
select * from user;

insert into usernote(user_id,note_id) 
values(1,1),
(1,2),
(1,3);

insert into notereminder(note_id,reminder_id)
values(1,1),
(2,2);

insert into notecategory(note_id, category_id)
values(1,2),
(2,2),
(3,2);

select * from user where user_id=1 and user_password='password';

select * from note where note_creation_date = '2019-05-06';

select * from category where category_creation_date >= '2019-05-05';

select note_id from usernote where user_id = (select user_id from user where user_name = 'Admin');

update note set note_title='Java 8',note_content='session started', note_status='started' 
where note_id=1;

select n.note_id,n.note_title, n.note_content, n.note_status, n.note_creation_date from note n
join usernote un on n.note_id = un.note_id 
where user_id = 1;

select n.note_id,n.note_title, n.note_content, n.note_status, n.note_creation_date from note n
join notecategory nc on n.note_id = nc.note_id 
where nc.category_id = 2;

select r.reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creator, reminder_creation_date 
from reminder r
join notereminder nr on r.reminder_id = nr.reminder_id 
where nr.note_id = 2;

select reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creator, reminder_creation_date 
from reminder where reminder_id = 1;

insert into note(note_title, note_content, note_status, note_creation_date)
values('React','session start at 2 PM', 'not-started',date(now()));

insert into usernote(user_id,note_id) 
values(2,4);



insert into note(note_title, note_content, note_status, note_creation_date)
values('.Net','session start at 2 PM', 'not-started',date(now()));

insert into notecategory(note_id,category_id) 
values(2,5);

insert into reminder(reminder_name, reminder_descr, reminder_type, reminder_creator, reminder_creation_date)
values('C#','C# will start in next 1 hour','medium', 1,date(now()));

insert into notereminder(note_id,reminder_id)
values(1,3);

select * from user;
select * from usernote;

delete usernote, note from usernote join note 
where usernote.note_id = note.note_id 
and usernote.user_id=2 and note.note_id=5; 

delete notecategory, note from notecategory join note where notecategory.note_id = note.note_id and notecategory.category_id=1 and note.note_id=4;



select * from note;
delete from note where note_id=3;

delimiter |

CREATE TRIGGER trigger_before_note_deleted BEFORE DELETE ON note
  FOR EACH ROW
  BEGIN
    delete from usernote where note_id = OLD.note_id;
    delete from notecategory where note_id = OLD.note_id;
    delete from notereminder where note_id = OLD.note_id;
  END;
|

delimiter ;

select * from note;
select * from user;
select * from usernote;

delete from user where user_id=3;

delimiter |

CREATE TRIGGER trigger_before_user_deleted BEFORE DELETE ON user
  FOR EACH ROW
  BEGIN
    delete usernote, note from usernote join note 
	where usernote.note_id = note.note_id 
	and usernote.user_id=OLD.user_id; 
  END;
|

delimiter ;




