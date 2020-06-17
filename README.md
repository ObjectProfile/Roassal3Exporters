# Roassal3Exporter
Exporters for [Roassal3](https://github.com/ObjectProfile/Roassal3) and Pharo 9


Execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
    load.
``` 


# Example of usage:
```Smalltalk
classes := Collection withAllSubclasses.

c := RSCanvas new.
shapes := classes collect: [ :cls |
	RSBox new model: cls; 
		height: (cls numberOfMethods max: 5);
		width: (cls instVarNames size * 4 max: 5); 
		@ RSPopup;
		@ RSDraggable  ].
	
c addAll: shapes.

eb := RSEdgeBuilder orthoVertical.
eb withVerticalAttachPoint.
eb canvas: c.
eb connectFrom: #superclass.

RSTreeLayout on: shapes.
c @ RSCanvasController.

(c shapes shapeFromModel: Collection) @ (RSLabeled new text:'Über, genießen').

RSPDFExporter new
		canvas: c;
		exportToFile: '/tmp/foo.pdf' asFileReference

```        

# Video

You can export your animations in a video you will need to load this baseline.

```Smalltalk
Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
    load: 'Video'.
```

 Also you will need to install ffmpeg.
 
 In your terminal use
```
xcode-select --install
```

or:

```
brew install ffmpeg
```

# Example video

```Smalltalk
| c b |
c := RSCanvas new.
b := RSBox new
	extent: 100@100;
	withBorder.
c addShape: b.
c newAnimation 
	easing: RSEasing bounce;
	from: -100@ -100;
	to: 100@100;
	on: b set: #position:.
c newAnimation 
	from: Color red;
	to: Color blue;
	on: b set: #color:.
c newAnimation 
	from: 0;
	to: 10;
	on: b border set: 'width:'.
c 
	when:RSMouseClick
	do: [ c animations do: #pause ];
	when: RSMouseDoubleClick 
	do: [ c animations do: #continue ].
c clearBackground: false.

c videoExporter
	duration: 2 seconds;
	fileName: 'Roassal3Demo';
	export
```
<a href="https://vimeo.com/429861918" target="_blank" title="Roassal3 video demo - Click to Watch!">
<img src="https://user-images.githubusercontent.com/10532890/84852814-c695a680-b02b-11ea-8070-3396c0b8931e.png" width="300">
</a>

