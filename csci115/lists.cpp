#include <assert.h>
#include <cstdlib>
#include <iostream>
#include "List.h"

using namespace std;


// Singly linked list node with freelist support
template <typename E> class Link
{

private:
     static Link<E>* freelist; // Reference to freelist head
     static int numactive;    // the number of active nodes between all linked-lists
      static int numfree;     // the number of free nodes on the free list


public:

   E element; // Value for this node
   Link* next; // Point to next node in list

// Constructors
Link(const E& elemval, Link* nextval =NULL)
    { element = elemval; next = nextval; }

Link(Link* nextval =NULL) 
     { next = nextval; }


void *operator new(size_t) 
 {
     
       Link<E>* return_val;

       numactive++;     //increment the number of active nodes

       if (numfree > 0)   // free list not empty
        {  
          numfree--;    //decrement the number of free nodes if numfree is greater than zero  (i.e., the new linked-list node came from the free list)
          return_val = freelist;    // Can take from freelist
          freelist = freelist->next;
        } 
       
        else 
          return_val = ::new Link;  // Create space
       

       return return_val;
  } 

// Overloaded delete operator
void operator delete(void*ptr) 
 {

    numactive--;   // a node deleted from a linked-list is always placed onto the free list, so numactive and numfree are decremented and incremented, respectively.
    numfree++;

   ((Link<E>*)ptr)->next = freelist; // Put on freelist
    freelist = (Link<E>*)ptr;
  
 }
 
 static int getnumActive()
 { return numactive; }
 
 static int getnumFree()
 {return numfree; }
 
};

// The freelist head pointer is actually created here
template <typename E>
Link<E>* Link<E>::freelist = NULL;

template <typename E> 
int Link<E>::numactive = 0;  //initialize numactive to zero

template <typename E> 
int Link<E>::numfree = 0;   //initialize numfree to zero


// Linked list implementation
template <typename E> class LList: public List<E>
{

  private:
    
    Link<E>* head; // Pointer to list header
    Link<E>* tail; // Pointer to last element
    Link<E>* curr; // Access to current element

  void init() 
  { // Intialization helper method
  curr = tail = head = new Link<E>;
  }
   
   
void removeall() 
{ // Return link nodes to free store

  while(head != NULL) 
  {
     curr = head;
     head = head->next;
     delete curr;
  }
}

public:
       
  LList() { init(); } // Constructor
  ~LList() { removeall(); } // Destructor
  void print() const; // Print list contents

  void clear() { removeall(); init(); } // Clear list

void prepend(const E& it)
{
     
     //create a new linked-list node that stores the element it, and has it's next pointer set to point at head->next
     //then head->next is updated to point at this new node
   
   if(head == tail)
     head->next = tail =  new Link<E>(it, head->next);
     
   else
     head->next = new Link<E>(it, head->next);
    
}

void append(const E& it) 
{ 
    
    //create a new linked-list node that stores the element it, and has it's next pointer set to point at NULL
    //then tail is updated to point at this new node
    
    if(head == tail)
     tail = tail->next = head->next = new Link<E>(it, NULL);
     
    else
       tail = tail->next = new Link<E>(it, NULL);
}


void moveToStart() // Place curr at list start
  { curr = head; }



// Move curr one step right; no change if already at end
bool next()
{ 
  if (curr != tail) 
  {   curr = curr->next;
      return true;
   }  
   
   return false;
     
}



const E& getValue() const 
{ // Return current element
   
   assert(curr->next != NULL);   
    return curr->next->element;
   
}

int numActive()  //return the number of active nodes
{  
   
    return Link<E>::getnumActive();  
   
}

int numFree()  //return the number of free nodes
{ 
  
    return  Link<E>::getnumFree(); 
    
}

};

