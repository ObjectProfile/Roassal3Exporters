Class {
	#name : #RSExporterFontStrategy,
	#superclass : #Object,
	#instVars : [
		'dictionary'
	],
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #adding }
RSExporterFontStrategy >> addCustomFont: string given: association [

	self assert: (string isString and: [ string notEmpty ]).
	self assert: association isAssociation.
	dictionary ifNil: [ dictionary := Dictionary new ].
	dictionary at: string put: association
]

{ #category : #export }
RSExporterFontStrategy >> export: collection on: stream [

	self subclassResponsibility
]

{ #category : #accessing }
RSExporterFontStrategy >> fontName: string [

	^ dictionary ifNil: [ string ] ifNotNil: [ 
		dictionary
			at: string
			ifPresent: [ :assoc | assoc key ]
			ifAbsent: [ string ] ]
]
