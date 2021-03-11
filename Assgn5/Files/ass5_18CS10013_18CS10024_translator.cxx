#include "ass5_18CS10013_18CS10024_translator.h"
#include<sstream>
#include<string>
#include<iostream>
using namespace std;


symtable* globalST;					
quadArray Q;						
string var_type;						
symtable* ST;						
sym* currSymbolPtr; 					
basicType bt;                      
long long int instr_count;	
bool debug_on;			
void printpattern(){cout<<"";}   

sym::sym(string name, string t, symboltype* arrtype, int width) 
{     
		printpattern();
		(*this).name=name;
		printpattern();
		type=new symboltype(t,arrtype,width);       
		printpattern();
		size=computeSize(type);                   
		printpattern();
		offset=0;                                  
		printpattern();
		val="-";                                    
		printpattern();
		nested=NULL;                               
		printpattern();
}
sym* sym::update(symboltype* t) 
{
	printpattern();	
	type=t;										
	printpattern();
	(*this).size=computeSize(t);                
	printpattern();
	return this;                                 
}

symboltype::symboltype(string type,symboltype* arrtype,int width)       
{
	printpattern();
	(*this).type=type;
	printpattern();
	(*this).width=width;
	printpattern();
	(*this).arrtype=arrtype;
	printpattern();
}
symtable::symtable(string name)            
{
	(*this).name=name;
	printpattern();
	count=0;                           
	printpattern();
}
sym* symtable::lookup(string name)              
{
	sym* symbol;
	lsit it;                    
	it=table.begin();
	while(it!=table.end()) 
	{
		if(it->name==name) 
			return &(*it);         
		it++;
	}
	
	symbol= new sym(name);
	table.push_back(*symbol);           
	return &table.back();              
}
void symtable::update()                      
{
	list<symtable*> tb;                 
	int off;
	lsit it;
	it=table.begin();
	while(it!=table.end()) 
	{
		if(it==table.begin()) 
		{
			it->offset=0;
			off=it->size;
		}
		else 
		{
			it->offset=off;
			off=it->offset+it->size;
		}
		if(it->nested!=NULL) 
			tb.push_back(it->nested);
		it++;
	}
	list<symtable*>::iterator it1;
	it1=tb.begin();
	while(it1 !=tb.end()) 
	{
	  (*it1)->update();
	  it1++;
	}
}

void symtable::print()                            
{
	int next_instr=0;
	list<symtable*> tb;                      
	for(int t1=0;t1<50;t1++) 
		cout<<"__";             
	cout<<endl;
	cout<<"Table Name: "<<(*this).name<<"\t\t\t Parent Name: ";          
	if(((*this).parent==NULL))
		cout<<"NULL"<<endl;
	else
		cout<<(*this).parent->name<<endl; 
	for(int ti=0;ti<50;ti++) 
		cout<<"__";
	cout<<endl;
	cout<<"Name";          
	generateSpaces(11);
	cout<<"Type";              
	generateSpaces(16);
	cout<<"Initial Value";    
	generateSpaces(7);
	cout<<"Size";              
	generateSpaces(11);
	cout<<"Offset";            
	generateSpaces(9);
	cout<<"Nested"<<endl;       
	generateSpaces(100);
	cout<<endl;
	ostringstream str1;
	 
	for(lsit it=table.begin(); it!=table.end(); it++) {          
		
		cout<<it->name;                                   
		
		generateSpaces(15-it->name.length());
		     
		string typeres=printType(it->type);               
			
		cout<<typeres;
		
		generateSpaces(20-typeres.length());
		 
		cout<<it->val;                                    
		
		generateSpaces(20-it->val.length());
		
		cout<<it->size;                                   
		
		str1<<it->size;
		
		generateSpaces(15-str1.str().length());
		
		str1.str("");
		
		str1.clear();
		
		cout<<it->offset;                               
		
		str1<<it->offset;
		
		generateSpaces(15-str1.str().length());
		
		str1.str("");
		
		str1.clear();
		
		if(it->nested==NULL) {                             
			
			cout<<"NULL"<<endl;
				
		}
		else {
			
			cout<<it->nested->name<<endl;
				
			tb.push_back(it->nested);
			
		}
	}
	
	for(int i=0;i<100;i++) 
		cout<<"-";
	cout<<"\n\n";
	for(list<symtable*>::iterator it=tb.begin(); it !=tb.end();++it) 
	{
    	(*it)->print();                               
	}
			
}
quad::quad(string res,string arg1,string op,string arg2)           
{
	printpattern();
	(*this).res=res;
	printpattern();
	(*this).arg1=arg1;
	printpattern();
	(*this).op=op;
	printpattern();
	(*this).arg2=arg2;
	printpattern();
}
quad::quad(string res,int arg1,string op,string arg2)             
{
	printpattern();
	(*this).res=res;
	printpattern();
	(*this).arg2=arg2;
	printpattern();
	(*this).op=op;
	printpattern();
	(*this).arg1=convertIntToString(arg1);
	printpattern();
}
quad::quad(string res,float arg1,string op,string arg2)           
{
	printpattern();
	(*this).res=res;
	printpattern();
	(*this).arg2=arg2;
	printpattern();
	(*this).op=op;
	printpattern();
	(*this).arg1=convertFloatToString(arg1);
	printpattern();
}
void quad::print() 
{                                    
	
	int next_instr=0;	
	if(op=="+")
	{	
		printpattern();	
		(*this).type1();
	}
	else if(op=="-")
	{				
		printpattern();
		(*this).type1();
	}
	else if(op=="*")
	{
		printpattern();
		(*this).type1();
	}
	else if(op=="/")
	{	
		printpattern();	
		(*this).type1();
	}
	else if(op=="%")
	{
		printpattern();
		(*this).type1();
	}
	else if(op=="|")
	{
		printpattern();
		(*this).type1();
	}
	else if(op=="^")
	{
		printpattern();	
		(*this).type1();
	}
	else if(op=="&")
	{
		printpattern();				
		(*this).type1();
	}
	
	else if(op=="==")
	{
		printpattern();
		(*this).type2();
	}
	else if(op=="!=")
	{
		printpattern();
		(*this).type2();
	}
	else if(op=="<=")
	{
		printpattern();
		(*this).type2();
	}
	else if(op=="<")
	{	
		printpattern();			
		(*this).type2();
	}
	else if(op==">")
	{
		printpattern();
		(*this).type2();
	}
	else if(op==">=")
	{
		printpattern();				
		(*this).type2();
	}
	else if(op=="goto")
	{
		printpattern();				
		cout<<"goto "<<res;
	}	
	
	else if(op==">>")
	{
		printpattern();
		(*this).type1();
	}
	else if(op=="<<")
	{
		printpattern();				
		(*this).type1();
	}
	else if(op=="=")
	{
		printpattern();				
		cout<<res<<" = "<<arg1 ;
	}					
	
	else if(op=="=&")
	{
		printpattern();				
		cout<<res<<" = &"<<arg1;
	}
	else if(op=="=*")
	{
		printpattern();
		cout<<res	<<" = *"<<arg1 ;
	}
	else if(op=="*=")
	{	
		printpattern();			
		cout<<"*"<<res	<<" = "<<arg1 ;
	}
	else if(op=="uminus")
	{
		printpattern();
		cout<<res<<" = -"<<arg1;
	}
	else if(op=="~")
	{
		printpattern();				
		cout<<res<<" = ~"<<arg1;
	}
	else if(op=="!")
	{
		printpattern();
		cout<<res<<" = !"<<arg1;
	}
	
	else if(op=="=[]")
	{
		printpattern();
		
		 cout<<res<<" = "<<arg1<<"["<<arg2<<"]";
	}
	else if(op=="[]=")
	{	
		printpattern(); 
		
		cout<<res<<"["<<arg1<<"]"<<" = "<< arg2;
	}
	else if(op=="return")
	{
		printpattern(); 			
		cout<<"return "<<res;
	}
	else if(op=="param")
	{
		printpattern(); 			
		cout<<"param "<<res;
	}
	else if(op=="call")
	{
		printpattern(); 			
		cout<<res<<" = "<<"call "<<arg1<<", "<<arg2;
	}
	else if(op=="label")
	{
		printpattern();
		cout<<res<<": ";
	}	
	else
	{	
		cout<<"Can't find "<<op;
	}			
	cout<<endl;
	
}
void quad::type1()
{
	printpattern();
	cout<<res<<" = "<<arg1<<" "<<op<<" "<<arg2;
	printpattern();
}
void quad::type2()
{
	printpattern();
	cout<<"if "<<arg1<< " "<<op<<" "<<arg2<<" goto "<<res;
	printpattern();
}

void basicType::addType(string t, int s)          
{
	printpattern();
	type.push_back(t);
	printpattern();
	size.push_back(s);
	printpattern();
}
void quadArray::print()                                  
{
	for(int i=0;i<50;i++) 
		cout<<"__";
	cout<<endl;
	cout<<"Three Address Code:"<<endl;         
	for(int i=0;i<50;i++) 
		cout<<"__";
	cout<<endl;
	int j=0;
	vector<quad>::iterator it;
	it=Array.begin();
	while(it!=Array.end()) 
	{
		if(it->op=="label") 
		{           
			cout<<endl<<"L"<<j<<": ";
			it->print();
		}
		else {                        
			cout<<"L"<<j<<": ";
			generateSpaces(4);
			it->print();
		}
		it++;j++;
	}
	for(int i=0;i<50;i++) 
		cout<<"__";      
	cout<<endl;
}

void generateSpaces(int n)
{
	printpattern();
	while(n--) 
		cout<<" ";
	printpattern();
}
string convertIntToString(int a)                  
{
	stringstream strs;                      
    strs<<a; 
    string temp=strs.str();
    char* integer=(char*) temp.c_str();
	string str=string(integer);
	return str;                              
}
string convertFloatToString(float x)                        
{
	std::ostringstream buff;
	buff<<x;
	return buff.str();
}
void emit(string op, string res, string arg1, string arg2) 
{            
	quad *q1= new quad(res,arg1,op,arg2);
	printpattern();
	Q.Array.push_back(*q1);
}
void emit(string op, string res, int arg1, string arg2) 
{                 
	quad *q2= new quad(res,arg1,op,arg2);
	printpattern();
	Q.Array.push_back(*q2);
}
void emit(string op, string res, float arg1, string arg2) 
{                 
	quad *q3= new quad(res,arg1,op,arg2);
	Q.Array.push_back(*q3);
}
sym* convertType(sym* s, string rettype) 
{                            
	sym* temp=gentemp(new symboltype(rettype));	
	if((*s).type->type=="float")                                    
	{
		if(rettype=="int")                                      
		{
			emit("=",temp->name,"float2int("+(*s).name+")");
			return temp;
		}
		else if(rettype=="char")                               
		{
			emit("=",temp->name,"float2char("+(*s).name+")");
			return temp;
		}
		return s;
	}
	else if((*s).type->type=="int")                                 
	{
		if(rettype=="float") 									
		{
			emit("=",temp->name,"int2float("+(*s).name+")");
			return temp;
		}
		else if(rettype=="char") 								
		{
			emit("=",temp->name,"int2char("+(*s).name+")");
			return temp;
		}
		return s;
	}
	else if((*s).type->type=="char") 								  
	{
		if(rettype=="int") 									
		{
			emit("=",temp->name,"char2int("+(*s).name+")");
			return temp;
		}
		if(rettype=="double") 							
		{
			emit("=",temp->name,"char2double("+(*s).name+")");
			return temp;
		}
		return s;
	}
	return s;
}

void changeTable(symtable* newtable) 
{	      
	printpattern();
	ST = newtable;
	printpattern();
} 

bool compareSymbolType(sym*& s1,sym*& s2)
{ 	
	printpattern();symboltype* type1=s1->type;                     
	printpattern();symboltype* type2=s2->type;
	int flag=0;
	if(compareSymbolType(type1,type2)) 
		flag=1;       
	else if(s1=convertType(s1,type2->type)) 
		flag=1;	
	else if(s2=convertType(s2,type1->type)) 
		flag=1;
	if(flag)
		return true;
	else 
		return false;
}
bool compareSymbolType(symboltype* t1,symboltype* t2)
{ 	
	printpattern();
	int flag=0;
	if(t1==NULL && t2==NULL) 
		flag=1;               
	else if(t1==NULL || t2==NULL || t1->type!=t2->type) 
		flag=2;                     
	
	if(flag==1)
		return true;
	else if(flag==2)
		return false;
	else 
		return compareSymbolType(t1->arrtype,t2->arrtype);       
}
void backpatch(list<int> list1,int addr)               
{
	string str=convertIntToString(addr);             
	list<int>::iterator it;
	it=list1.begin();
	printpattern();
	while( it!=list1.end()) 
	{
		Q.Array[*it].res=str;                     
		it++;
	}
}
list<int> makelist(int init) 
{
	list<int> newlist(1,init);                    
	printpattern();
	return newlist;
}
list<int> merge(list<int> &a,list<int> &b)
{
	a.merge(b);                              
	printpattern();
	return a;
}
void convertIntToBool(Expression* e)        
{	
	if(e->type!="bool")                
	{
		e->falselist=makelist(nextinstr());    
		emit("==","",e->loc->name,"0");
		e->truelist=makelist(nextinstr());
		emit("goto","");
	}
}
void update_nextinstr()
{
	instr_count++;
	if(debug_on==1)
	{
		cout<<"Current Line Number:"<<instr_count<<endl;
		cout<<"Press [ENTER] to continue:";
		cin.get();
	}
}
void debug()
{
	if(debug_on==1)
		cout<<instr_count<<endl;
}
void convertBoolToInt(Expression* e) 
{	
	if(e->type=="bool") 
	{
		printpattern();
		e->loc=gentemp(new symboltype("int"));         
		printpattern();
		backpatch(e->truelist,nextinstr());
		printpattern();
		emit("=",e->loc->name,"true");
		printpattern();
		int p=nextinstr()+1;
		printpattern();
		string str=convertIntToString(p);
		printpattern();
		emit("goto",str);
		printpattern();
		backpatch(e->falselist,nextinstr());
		printpattern();
		emit("=",e->loc->name,"false");
		printpattern();
	}
}
int nextinstr() 
{
	printpattern();
	return Q.Array.size();                
}
sym* gentemp(symboltype* t, string str_new) 
{           //generate temp variable
	string tmp_name = "t"+convertIntToString(ST->count++);             
	sym* s = new sym(tmp_name);
	(*s).type = t;
	(*s).size=computeSize(t);                        
	(*s).val = str_new;
	ST->table.push_back(*s);                        
	return &ST->table.back();
}
int computeSize(symboltype* t)                   
{
	if(t->type.compare("void")==0)	
		return bt.size[1];
	else if(t->type.compare("char")==0) 
		return bt.size[2];
	else if(t->type.compare("int")==0) 
		return bt.size[3];
	else if(t->type.compare("float")==0) 
		return  bt.size[4];
	else if(t->type.compare("arr")==0) 
		return t->width*computeSize(t->arrtype);    
	else if(t->type.compare("ptr")==0) 
		return bt.size[5];
	else if(t->type.compare("func")==0) 
		return bt.size[6];
	else 
		return -1;
}
string printType(symboltype* t)                    
{
	if(t==NULL) return bt.type[0];
	if(t->type.compare("void")==0)	return bt.type[1];
	else if(t->type.compare("char")==0) return bt.type[2];
	else if(t->type.compare("int")==0) return bt.type[3];
	else if(t->type.compare("float")==0) return bt.type[4];
	else if(t->type.compare("ptr")==0) return bt.type[5]+"("+printType(t->arrtype)+")";       
	else if(t->type.compare("arr")==0) 
	{
		string str=convertIntToString(t->width);                                
		return bt.type[6]+"("+str+","+printType(t->arrtype)+")";
	}
	else if(t->type.compare("func")==0) return bt.type[7];
	else return "NA";
}
int main()
{
	bt.addType("null",0);                 
	bt.addType("void",0);
	bt.addType("char",1);
	bt.addType("int",4);
	bt.addType("float",8);
	bt.addType("ptr",4);
	bt.addType("arr",0);
	bt.addType("func",0);
	instr_count = 0;   
	debug_on= 0;       
	globalST=new symtable("Global");                         
	ST=globalST;
	yyparse();												 
	globalST->update();										 
	cout<<"\n";
	Q.print();	
	globalST->print();										
													
};
