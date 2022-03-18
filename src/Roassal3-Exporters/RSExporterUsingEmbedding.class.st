"
I represent the exporter using a font embedding.

I am responsible of exporting in a file the information of the fonts.

Public API and Key Messages

- export:on: receives a collection, and a stream. For each fontName in the collection, writes in the stream the content of the corresponding file.

RSExporterUsingEmbedding new
	addCustomFont: 'Source Sans Pro'
	given: 'Ubuntu Mono' -> 'ubuntu-mono.css';
	export: {'Source Sans Pro'} on: stream

"
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
