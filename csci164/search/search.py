# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]

def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first.

    Your search algorithm needs to return a list of actions that reaches the
    goal. Make sure to implement a graph search algorithm.

    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:

    print "Start:", problem.getStartState()
    print "Is the start a goal?", problem.isGoalState(problem.getStartState())
    print "Start's successors:", problem.getSuccessors(problem.getStartState())
    """
    "*** YOUR CODE HERE ***"
    #I should use a stack from util.py
    myStack = util.Stack()		#My stack to store the states, moves, and cost
    setState = set()			#A set of states that I visited
    myStack.push((problem.getStartState(), [], 0))
	
    while not myStack.isEmpty():
		myState, myMoves, myCost = myStack.pop()  #Get the current state, move, cost
		#Maybe we will use the cost later for something (least cost path?)
		if(myState in setState):
			continue
		setState.add(myState)
		if problem.isGoalState(myState): #If the current state is our goal
			return myMoves #then return the set of directions to pacman
		for state, direction, cost in problem.getSuccessors(myState):
			myStack.push((state, myMoves + [direction], myCost))
    return []
    util.raiseNotDefined()

def breadthFirstSearch(problem):
    """Search the shallowest nodes in the search tree first."""
    "*** YOUR CODE HERE ***"
    #I should use a Queue to hold the paths FIFO
    myQueue = util.Queue()
    setState = [] #A set to hold visited nodes
	
    #Starting from my start state, we push that onto the Queue
    myQueue.push( (problem.getStartState(), []) ) #Base case
    
    #Then we check if that starting state is our goal?
    #If not, then we will put the starting state into a set()
    #and then we will move onto any child node that the starting
    #state had. And that's were we will push to the queue 
    #any edge nodes and continue the same loop
    while not myQueue.isEmpty():
        node, actions = myQueue.pop()
        for coord, direction, steps in problem.getSuccessors(node):
            if problem.isGoalState(coord):
                return actions + [direction]
            myQueue.push( (coord, actions + [direction]) )
            setState.append(coord)
    return []
    util.raiseNotDefined()

    #Iterate through each children
    """children = problem.getSuccessors(parent[0])
	  for child in children:
	      parentMap[child] = parent
		  stack.push(child)"""
	
def uniformCostSearch(problem):
    """Search the node of least total cost first."""
    "*** YOUR CODE HERE ***"
    #I'll have to use a priority queue for the least cost
    pQueue = util.PriorityQueue()
    
    #Starting from the current state, get the successors
    #action moves and costs then put current state into
	#the visited states
	
    setState = set() #To store my visited nodes
	
    #Start with the starting node
	#Since it's prioritized by cost, then I need to
	#make it a tuple so that the priority queue can
	#recognize the cost value
	#The format of it is (priority, object)?
    pQueue.push( (problem.getStartState(), []), 0)
	
    while not pQueue.isEmpty():
        currNode, currCost = pQueue.pop()
        if problem.isGoalState(currNode):
            return currCost
        setState.add(currNode)
        for nextNode, direction, nextCost in problem.getSuccessors(currNode):
            if not nextNode in setState:
                newCost = currCost + [direction]
                pQueue.push( (nextNode, newCost), problem.getCostOfActions(newCost))
    return []
    util.raiseNotDefined()

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    "*** YOUR CODE HERE ***"
	#Path cost weight the priority queue
    closedset = []
    fringe = util.PriorityQueue()
    start = problem.getStartState()
    fringe.push( (start, []), heuristic(start, problem) )
	
    while not fringe.isEmpty():
        node, actions = fringe.pop()
		
        if problem.isGoalState(node):
            return actions
		
        closedset.append(node)
		
        for coord, direction, cost in problem.getSuccessors(node):
            if not coord in closedset:
                new_actions = actions + [direction]
                score = problem.getCostOfActions(new_actions) + heuristic(coord, problem)
                fringe.push( (coord, new_actions), score )
    return []
    util.raiseNotDefined()


# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
