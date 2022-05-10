#define CHAR 1
#define INT 2
#define FLOAT 3
#define DOUBLE 3

typedef struct symbol		//data structure of items in the list
{
	char* name;			//identifier name
	int size;			//length of identifier name
	int type;			//identifier type
	char* val;			//value of the identifier
	int line;			//line number
	int scope;			//scope
	struct symbol* next;
}symbol;

typedef struct table		//keeps track of the start of the list
{
	symbol* head;
}table;

static table* t;

table* init_table();	//allocate a new empty symbol table
symbol* init_symbol(char* name, int size, int type, int lineno,int scope);		//allocates space for items in the list
void insert_symbol(char* name, int size, int type, int lineno,int scope);		//inserts symbols into the table when declared
void insert_val(char* name, char* v, int line);	//inserts values into the table when initialised		
int check_sym_tab(char* name);			//checks symbol table whether the variable has been declared or not
void display_sym_tab();				//displays symbol table
char* retrieve_val(char* name);		//retrieves value from symbol table
int retrieve_type(char* name);		//retrieves type from symbol table
int type_check(char* value);		//checks type of value string
int size(int type);			//gets the size of the type(macros defined before)
