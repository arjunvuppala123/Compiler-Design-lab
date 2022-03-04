#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

table* init_table()	
{
	/*
        allocate space for table pointer structure eg (t_name)* t
        initialise head variable eg t->head
        return structure
    	*/
    table* t = (table*)malloc(sizeof(table));
    t->head = NULL;
    return t;
}

symbol* init_symbol(char* name, int size, int type, int lineno, int scope) //allocates space for items in the list
{
	/*
        allocate space for entry pointer structure eg (s_name)* s
        initialise all struct variables(name, value, type, scope, length, line number)
        return structure
    	*/
    symbol* s = (symbol*)malloc(sizeof(symbol));
    s->name = name;
    s->val = 0;
    s->type = type;
    s->scope = scope;
    s->size = size;
    s->line = lineno;
    return s;
}
insert_into_table(arguments)/* 
 arguments can be the structure s_name already allocated before this function call
 or the variables to be sent to allocate_space_for_table_entry for initialisation        
*/
{
    /*
        check if table is empty or not using the struct table pointer
        else traverse to the end of the table and insert the entry
    */
    if(t->head == NULL)
    {
        t->head = allocate_space_for_table_entry(arguments);
    }
    else
    {
        symbol* temp = t->head;
        while(temp->next != NULL)
        {
            temp = temp->next;
        }
        temp->next = allocate_space_for_table_entry(arguments);
    }
}

check_symbol_table(name) //return a value like integer for checking
{
    /*
        check if table is empty and return a value like 0
        else traverse the table
        if entry is found return a value like 1
        if not return a value like 0
    */
    if(t->head == NULL)
    {
        return 0;
    }
    else
    {
        symbol* temp = t->head;
        while(temp != NULL)
        {
            if(strcmp(temp->name, name) == 0)
            {
                return 1;
            }
            temp = temp->next;
        }
        return 0;
    }
}

insert_value_to_name(name,value)
{
    /*
        if value is default value return back
        check if table is empty
        else traverse the table and find the name
        insert value into the entry structure
    */
    if(value == 0)
    {
        return;
    }
    if(t->head == NULL)
    {
        return;
    }
    else
    {
        symbol* temp = t->head;
        while(temp != NULL)
        {
            if(strcmp(temp->name, name) == 0)
            {
                temp->val = value;
                return;
            }
            temp = temp->next;
        }
    }
}

display_symbol_table()
{
    /*
        traverse through table and print every entry
        with its struct variables
    */
    if(t->head == NULL)
    {
        printf("\nSymbol table is empty\n");
    }
    else
    {
        symbol* temp = t->head;
        while(temp != NULL)
        {
            printf("\nName: %s\n", temp->name);
            printf("Value: %s\n", temp->val);
            printf("Type: %d\n", temp->type);
            printf("Scope: %d\n", temp->scope);
            printf("Size: %d\n", temp->size);
            printf("Line: %d\n", temp->line);
            temp = temp->next;
        }
    }
}
