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
			"<< ':wght@';
			<< asso value asSVGString;"<< ''');' ]
]
