/* Deklarasi fakta sementara */

/* Deklarasi Rules */

/* append List */
append([], X, X).
append([A|B], C, [A|D]) :- append(B,C,D).

/* Print isi list ke layar */
printlist([]).
printlist([A|B]) :- write(' '),write(A),nl,printlist(B).


/* Operasi Player */
player(Name, Health, Hunger, Thirst, Weapon, InventoryList).

player_init(Name) :-
	
	health_defaultplayer(Health),
	hunger_default(Hunger),
	thirst_default(Thirst),
	weapon_default(Weapon),
	inventory_default(InventoryList),
	asserta(player(Name, Health, Hunger, Thirst, Weapon, InventoryList)).

player_move(Direction) :-
	Direction == n, 

/* Operasi Health */
health_defaultplayer(Health) :-
	Health is 100.
health_defaultenemy(Health) :-
	Health is 50.
health_increase(CurrentHealth, Amount) :-
	Health is CurrentHealth+Amount.
health_decrease(CurrentHealth, Amount) :-
	Health is CurrentHealth-Amount.
health_get(Name,Health) :-
	player(Name,Health,_,_,_,_).

/* Operasi Hunger */
hunger_default(Hunger) :-
	Hunger is 100.
hunger_increase(CurrentHunger, Amount) :-
	Hunger is CurrentHunger+Amount.
hunger_decrease(CurrentHunger, Amount) :-
	Hunger is CurrentHunger-Amount.
hunger_get(Name,Hunger) :-
	player(Name,_,Hunger,_,_,_).

/* Operasi Thirst */
thirst_default(Thirst) :-
	Thirst is 100.
thirst_increase(CurrentThirst, Amount) :-
	Thirst is CurrentThirst+Amount.
thirst_decrease(CurrentThirst, Amount) :-
	Thirst is CurrentThirst-Amount.
thirst_get(Name,Thirst) :-
	player(Name,_,_,Thirst,_,_).

/* Operasi Weapon */
weapon_default(Weapon) :-
	Weapon = 'none'.

/* Operasi Inventory */
inventory_default(InventoryList) :-
	InventoryList = [].
inventory_get(Name,InventoryList) :-
	player(Name,_,_,_,_InventoryList).

/* Operasi Item */
item_take(CurrentInventoryList, Item) :-
	append(CurrentInventoryList, Item, NewInventoryList),
	asserta(player(Name, Health, Hunger, Thirst, Weapon, NewInventoryList)).

item_drop(CurrentInventoryList, Item) :-
	select(Item, CurrentInventoryList, NewInventoryList),
	asserta(player(Name, Health, Hunger, Thirst, Weapon, NewInventoryList)).

item_use(CurrentInventoryList, Item) :-
	select(Item, CurrentInventoryList, NewInventoryList),
	item == 'axe', use_weapon(axe).

item_use(CurrentInventoryList, Item) :-
	select(Item, CurrentInventoryList, NewInventoryList),
	item == 'antibiotic', use_medicine(antibiotic).

/* Deklarasi Enemy */
enemy(ID, Health)

enemy_init(ID) :-
	health_defaultenemy(Health),
	asserta(enemy(ID, Health)).
	

/* COMMAND */
start() :- player_init(),map_init().

status() :-
	write('Health : '), write(Health), nl,
	write('Hunger : '), write(Hunger), nl,
	write('Thirst : '), write(Thirst), nl,
	write('Weapon : '), write(Weapon), nl,
	write('Inventory : '), nl, InventoryList == [], 
	write('Your Inventory is Empty'), nl.

status() :-
	write('Health : '), write(Health), nl,
	write('Hunger : '), write(Hunger), nl,
	write('Thirst : '), write(Thirst), nl,
	write('Weapon : '), write(Weapon), nl,
	write('Inventory : '), nl, InventoryList \= [], 
	printlist(InventoryList), nl.
