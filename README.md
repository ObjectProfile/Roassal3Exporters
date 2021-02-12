# Roassal3Exporter
[![Build Status](https://travis-ci.com/ObjectProfile/Roassal3Exporters.svg?branch=master)](https://travis-ci.com/ObjectProfile/Roassal3Exporters) (https://github.com/ObjectProfile/Roassal3Exporters/workflows/CI/badge.svg)](https://github.com/ObjectProfile/Roassal3Exporters/actions)

Exporters for [Roassal3](https://github.com/ObjectProfile/Roassal3) and Pharo 9


Execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
    load.
```

Available exporters:

- PNG, with methods: `exportToPNG`, `pngExporter` or class `RSPNGExporter`
- SVG, with methods: `exportToSVG`, `svgExporter` or class `RSSVGExporter`
- PDF, with methods: `exportToPDF`, `pdfExporter` or class `RSPDFExporter`
- Video mp4 or mov, with: methods `exportToVideo`, `videoExporter` or class `RSVideoExporter`

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

You can access some of these exporters in the inspector

<img src="https://user-images.githubusercontent.com/10532890/84853801-ff367f80-b02d-11ea-9040-5de4920e7635.png" width="400"/>

# Video

You can export your animations in a video. Load this baseline to load its dependencies.

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
"result will be Roassal3Demo.mp4"
```

<a href="https://vimeo.com/429861918" target="_blank" title="Roassal3 video demo - Click to Watch!">
<img src="https://user-images.githubusercontent.com/10532890/84852814-c695a680-b02b-11ea-8070-3396c0b8931e.png" width="400">
</a>

You can export the video with transparency and then use that video to edit another video. Videos with transparency take more disk memory.

```Smalltalk
"..."
c color: Color transparent.
c videoExporter
	duration: 2 seconds;
	transparent;
	fileName: 'Roassal3Demo';
	export
"result will be Roassal3Demo.mov"
```

Windows users can not use the video exporter, because it depends on OSSubProcess and that project does not run well in windows, let us know if this is important to you to work on that.

# AFrame 3D

You can export a canvas to an html 3D basic exporter with AFrame <a href="https://aframe.io/" target="_blank">https://aframe.io/</a>

```Smalltalk
Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
    load: 'AFrame'.
```

Then execute the example `example12AFrameExport`, you will get:

<img src="https://user-images.githubusercontent.com/10532890/90902971-4842e100-e39b-11ea-93fe-418cb1b5e0f8.png" width="400">
