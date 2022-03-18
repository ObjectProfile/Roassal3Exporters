"
I represent the exporter of a font using url.

I am responsible to export the urls of the fonts.

Public API and Key Messages

- export:on: receives a collection, and a stream. For each fontName in the collection, writes in the stream the url of the corresponding font to be exported.  

RSExporterUsingURL new 
	addCustomFont: 'Source Sans Pro' given: 'Ubuntu Mono' -> 'https://fonts.googleapis.com/css2?family='
	export: {'Source Sans Pro'} on: stream
 
"
Class {
	#name : #RSExporterUsingURL,
	#superclass : #RSExporterFontStrategy,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #initialization }
RSExporterUsingURL >> defaultURL [
	
	^ 'https://fonts.googleapis.com/css2?family='
]

{ #category : #export }
RSExporterUsingURL >> export: collection on: stream [

	collection do: [ :aString | 
		| assoc |
		assoc := dictionary ifNil: [ nil ] ifNotNil: [ dictionary at: aString ifAbsent: [ nil ] ].
		stream
			crlf;
			<< '@import url(''';
			<< (assoc ifNil: [ self defaultURL ] ifNotNil: [ assoc value ]);
			<< (assoc
					 ifNil: [ aString copyReplaceAll: ' ' with: '+' ]
					 ifNotNil: [ assoc key copyReplaceAll: ' ' with: '+' ]);
			<< ''');' ]
]
