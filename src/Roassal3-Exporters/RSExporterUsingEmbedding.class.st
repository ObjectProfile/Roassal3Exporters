Class {
	#name : #RSExporterUsingEmbedding,
	#superclass : #RSExporterFontStrategy,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #export }
RSExporterUsingEmbedding >> export: collection on: stream [

	self assert: (dictionary isDictionary and: [ dictionary isNotEmpty ]).
	self assert: (dictionary keys includesAll: collection).
	collection do: [ :item | 
		stream crlf.
		(dictionary at: item) value asFileReference readStreamDo: [ :fileStream | 
			stream nextPutAll: fileStream contents ] ]
]
