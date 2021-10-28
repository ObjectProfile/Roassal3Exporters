Extension { #name : #RSBitmap }

{ #category : #'*Roassal3-Exporters' }
RSBitmap >> writeSVG2On: aRSSVG2Exporter [
	| s pt stream base64 pos ext rect |
	s := aRSSVG2Exporter stream.
 	pt := aRSSVG2Exporter pathTransform.
	stream := WriteStream on: ByteArray new.
	PNGReadWriter putForm: self form onStream: stream.
	base64 := Base64MimeConverter mimeEncode: stream contents readStream multiLine: false.
	
	rect := self baseRectangle.
	pos := rect topLeft.
	ext := rect extent.
	s
		<< '<image href="data:image/png;base64,';
		<< base64 contents;
		<< '" x="';
		<< pos x asSVGString;
		<< '" y="';
		<< pos y asSVGString;
		<< '" width="';
		<< ext x asSVGString;
		<< '" height="';
		<< ext y asSVGString;
		<< '" '.
	aRSSVG2Exporter writeMatrix: pt.
	s << '/>'; crlf.
]
