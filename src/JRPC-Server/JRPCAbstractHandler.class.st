"
I am an abstract handler that deal with JRPC request for the #methodName I have.

I define the common API expected from any handler.

My concrete subclasses must override #executeWithArguments: method to define what they do and #parametersNames returns the name of the parameters I expect.

I also know the #server to which I have been added (if any).
"
Class {
	#name : #JRPCAbstractHandler,
	#superclass : #Object,
	#instVars : [
		'server',
		'procedureName'
	],
	#category : #'JRPC-Server'
}

{ #category : #accessing }
JRPCAbstractHandler class >> defaultMethodName [
	"Returns the method name that will be set to the handler instance by default."
	^ self subclassResponsibility
]

{ #category : #'parameters-checking' }
JRPCAbstractHandler >> checkParametersForRequest: aJRPCRequestObject [
	aJRPCRequestObject params
		ifNil: [ 
			self parametersCount = 0
				ifFalse: [ JRPCInvalidParameters signal ] ].
	
	(aJRPCRequestObject params ifNil: [ #() ]) size = self parametersCount
		ifFalse: [ JRPCInvalidParameters signal ].
		
	(aJRPCRequestObject params isDictionary
		and: [ ((aJRPCRequestObject params keys union: self parametersNames) size ~= self parametersCount) ])
			ifTrue: [ JRPCInvalidParameters signal ]
]

{ #category : #accessing }
JRPCAbstractHandler >> defaultMethodName [
	^ self class defaultMethodName
]

{ #category : #evaluation }
JRPCAbstractHandler >> executeWithArguments: anArrayOrDictionary [
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractHandler >> parametersCount [
	"Returns the number of parameters expected by the handler."
	^ self parametersNames size
]

{ #category : #accessing }
JRPCAbstractHandler >> parametersNames [
	"Returns the names of the parameters expected by the handler as a collection."
	^ self subclassResponsibility
]

{ #category : #accessing }
JRPCAbstractHandler >> procedureName [
	^ procedureName ifNil: [ procedureName := self defaultMethodName ]
]

{ #category : #accessing }
JRPCAbstractHandler >> procedureName: anObject [
	procedureName := anObject
]

{ #category : #accessing }
JRPCAbstractHandler >> server [
	^ server
]

{ #category : #accessing }
JRPCAbstractHandler >> server: anObject [
	server := anObject
]