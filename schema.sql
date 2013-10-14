create table shows (
	id serial primary key, 
	title varchar(50) not null, 
	year varchar(4) not null,
	composer varchar(50) not null, 
	img_url varchar(400) not null
);
 

create table songs (
	id serial primary key, 
	title varchar(50) not null, 
	embed_url varchar(300) not null,
	show_id integer references shows(id)
);
