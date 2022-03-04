"
I represent the abstract class for the font strategy

My main responsabilities are:
	- add in a dictionary: the name of the fonts used in Roassal, their corresponding names of the fonts which are going to replace them in the exporter, and the corresponding information of these fonts (they can be: urls or file paths)

I interact with RSSVGExporter

Public API and Key Messages

- export:on: (subclass responsability) receives the font names to be exported and a stream
- addCustomFont:given: receives the font name used in Roassal and an association (fontName to use in the exporter, infotmation of the font)
- fontName: receives the font name used in Roassal and returns the fontName that is going to be used in the exporter 


 
"
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
