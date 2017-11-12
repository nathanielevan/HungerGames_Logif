/* Deklarasi fakta sementara */

/* Deklarasi Rules */

/* append List */
append([], X, X).
append([A|B], C, [A|D]) :- append(B,C,D).

/* Print isi list ke layar */
printlist([]).
printlist([A|B]) :- write(A),nl,printlist(B).


/* Operasi Player */
player(Name, Health, Hunger, Thirst, Weapon, InventoryList).

player_init(Name) :-
	health_default(Health),
	hunger_default(Hunger),
	thirst_default(Thirst),
	weapon_default(Weapon),
	inventory_default(InventoryList),
	asserta(player(Name, Health, Hunger, Thirst, Weapon, InventoryList)).

/* Operasi Health */
health_default(Health) :-
	Health is 100.
health_increase(CurrentHealth, Amount) :-
	Health is CurrentHealth+Amount.
health_decrease(CurrentHealth, Amount) :-
	Health is CurrentHealth-Amount.

/* Operasi Hunger */
hunger_default(Hunger) :-
	Hunger is 100.
hunger_increase(CurrentHunger, Amount) :-
	Hunger is CurrentHunger+Amount.
hunger_decrease(CurrentHunger, Amount) :-
	Hunger is CurrentHunger-Amount.

/* Operasi Thirst */
thirst_default(Thirst) :-
	Thirst is 100.
thirst_increase(CurrentThirst, Amount) :-
	Thirst is CurrentThirst+Amount.
thirst_decrease(CurrentThirst, Amount) :-
	Thirst is CurrentThirst-Amount.

/* Operasi Inventory */
inventory_default(InventoryList) :-
	InventoryList = [].

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


/* COMMAND */

status() :-
	write('Health : '), write(Health), nl,
	write('Hunger : '), write(Hunger), nl,
	write('Thirst : '), write(Thirst), nl,
	write('Weapon : '), write(Weapon), nl,
	write('Inventory : '), nl,
	printlist(InventoryList).


