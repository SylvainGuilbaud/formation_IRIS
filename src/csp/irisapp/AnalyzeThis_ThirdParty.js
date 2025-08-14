/*** Zen Module: AnalyzeThis_ThirdParty ***/

self._zenClassIdx['AbstractAmChart'] = 'AnalyzeThis_ThirdParty_AbstractAmChart';
self.AnalyzeThis_ThirdParty_AbstractAmChart = function(index,id) {
	if (index>=0) {AnalyzeThis_ThirdParty_AbstractAmChart__init(this,index,id);}
}

self.AnalyzeThis_ThirdParty_AbstractAmChart__init = function(o,index,id) {
	('undefined' == typeof _ZEN_Component_component__init) ?zenMaster._ZEN_Component_component__init(o,index,id):_ZEN_Component_component__init(o,index,id);
	o.backgroundTimerInterval = '1000';
	o.barColor = '';
	o.captions = '';
	o.captionsFromSource = false;
	o.cellAlign = '';
	o.cellSize = '';
	o.cellStyle = '';
	o.cellVAlign = 'top';
	o.controller = '';
	o.controllerId = '';
	o.cssLevel = '2';
	o.designMode = false;
	o.disabled = false;
	o.dragAndDrop = false;
	o.enableListing = false;
	o.groupClass = 'page';
	o.groupStyle = '';
	o.hintText = '';
	o.inlineSVG = false;
	o.labelPosition = 'top';
	o.lastModalIndex = '0';
	o.layout = ''; // encrypted
	o.nextIndex = '0';
	o.ongetcontroller = '';
	o.onnotifyView = '';
	o.pager = false;
	o.useSVG = false;
	o.useSoftModals = true;
	o.zenPersistentPopup = false;
}
function AnalyzeThis_ThirdParty_AbstractAmChart_serialize(set,s)
{
	var o = this;s[0]='604339197';s[1]=o.index;s[2]=o.id;s[3]=o.name;s[4]=set.addObject(o.parent,'parent');s[5]=set.addObject(o.composite,'composite');s[6]=o.SVGClassList;s[7]=o.UserSVGPackageList;s[8]=o.align;s[9]=o.aux;s[10]=o.backgroundTimerInterval;s[11]=o.barColor;s[12]=o.captions;s[13]=(o.captionsFromSource?1:0);s[14]=o.cellAlign;s[15]=o.cellSize;s[16]=o.cellStyle;s[17]=o.cellVAlign;s[18]=set.serializeList(o,o.children,true,'children');s[19]=o.containerStyle;s[20]=o.controller;s[21]=o.controllerId;s[22]=o.cssLevel;s[23]=(o.designMode?1:0);s[24]=(o.disabled?1:0);s[25]=(o.dragAndDrop?1:0);s[26]=(o.dragEnabled?1:0);s[27]=(o.dropEnabled?1:0);s[28]=(o.dynamic?1:0);s[29]=(o.enableListing?1:0);s[30]=o.enclosingClass;s[31]=o.enclosingStyle;s[32]=o.error;s[33]=o.groupClass;s[34]=o.groupStyle;s[35]=o.height;s[36]=(o.hidden?1:0);s[37]=o.hint;s[38]=o.hintClass;s[39]=o.hintStyle;s[40]=o.hintText;s[41]=(o.inlineSVG?1:0);s[42]=(o.isPopup?1:0);s[43]=(o.isSoftModal?1:0);s[44]=o.label;s[45]=o.labelClass;s[46]=o.labelDisabledClass;s[47]=o.labelPosition;s[48]=o.labelStyle;s[49]=o.lastModalIndex;s[50]=o.layout;s[51]=o.nextIndex;s[52]=o.onafterdrag;s[53]=o.onbeforedrag;s[54]=o.onclick;s[55]=o.ondrag;s[56]=o.ondrop;s[57]=o.ongetcontroller;s[58]=o.onhide;s[59]=o.onnotifyView;s[60]=o.onoverlay;s[61]=o.onrefresh;s[62]=o.onshow;s[63]=o.onupdate;s[64]=o.overlayMode;s[65]=(o.pager?1:0);s[66]=o.popupParent;s[67]=o.renderFlag;s[68]=(o.showLabel?1:0);s[69]=o.slice;s[70]=o.title;s[71]=o.tuple;s[72]=(o.useSVG?1:0);s[73]=(o.useSoftModals?1:0);s[74]=o.valign;s[75]=(o.visible?1:0);s[76]=o.width;s[77]=(o.zenPersistentPopup?1:0);
}
function AnalyzeThis_ThirdParty_AbstractAmChart_getSettings(s)
{
	s['name'] = 'string';
	s['barColor'] = 'string';
	s['captions'] = 'string';
	s['captionsFromSource'] = 'string';
	s['controllerId'] = 'id';
	s['enableListing'] = 'string';
	s['hintText'] = 'string';
	s['ongetcontroller'] = 'eventHandler';
	s['onnotifyView'] = 'eventHandler';
	s['pager'] = 'string';
	this.invokeSuper('getSettings',arguments);
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_adjustContentSize = function(load,width,height) {
var obj=document.getElementById('amchart'+this.index);
obj.style.width=width+'px';
obj.style.height=height+'px';
if (this.chart) {
this.chart.invalidateSize();
resizeGrid(this,width,height);
}
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_connectToController = function() {
this.controller = '';
if (!zenIsMissing(this.controllerId)) {
if (this.composite) {
this.controller = this.composite.getChildById(this.controllerId);
}
else {
this.controller = zenPage.getComponentById(this.controllerId);
}
if (this.controller && this.controller.register) {
this.controller.register(this);
}
else {
alert('ZEN: Unable to connect component to dataController (' + this.id + ').');
}
if (this.controller) {
if ('' == this.controller.modelError) {
this.controller.loadModel(false);
}
}
}
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_disconnectFromController = function() {
if (this.controller && this.controller.unregister) {
this.controller.unregister(this);
}
this.controller = '';
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_getConnectedController = function() {
var controller = this.getController();
if (null == controller) {
this.connectToController();
controller = this.getController();
}
return controller;
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_getController = function() {
if (this.ongetcontroller) {
return zenInvokeCallbackMethod(this.ongetcontroller,this,'ongetcontroller','view',this);
}
return (null == this.controller || '' == this.controller) ? null : this.controller;
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_notifyView = function(reason,data1,data2,data3) {
var ret = true;
if (this.onnotifyView) {
ret = zenInvokeCallbackMethod(this.onnotifyView,this,'onnotifyEvent','reason',reason,'data1',data1,'data2',data2,'data3',data3);
}
if (ret && this.notifyViewHandler) {
this.notifyViewHandler(reason,data1,data2,data3);
}
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_notifyViewHandler = function(reason,data1,data2,data3) {
switch(reason) {
case 'dataChange':
this.acquireData();
this.renderContents();
break;
case 'modelChange':
this.renderContents();
break;
}
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_renderSameParts = function(self) {
renderListingButton(self,"amchart");
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_sendEventToController = function(reason,data1,data2,data3) {
var controller = this.getController();
if (controller && controller.notifyController) {
controller.notifyController(this,reason,data1,data2,data3);
}
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_setControllerId = function(id) {
this.disconnectFromController();
this.controllerId = id;
this.connectToController();
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_GetListingSql = function(inMDX,inrange) {
	zenClassMethod(this,'GetListingSql','L,L','',arguments);
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_JavaInstalled = function() {
	return zenClassMethod(this,'JavaInstalled','','BOOLEAN',arguments);
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_LoadZenComponent = function(pNamespace,pName,pClassName,pCSSLevel) {
	return zenClassMethod(this,'LoadZenComponent','L,L,L,L','BOOLEAN',arguments);
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_MonitorBackgroundTask = function(pTaskID) {
	zenClassMethod(this,'MonitorBackgroundTask','L','',arguments);
}

self.AnalyzeThis_ThirdParty_AbstractAmChart_ReallyRefreshContents = function() {
	zenInstanceMethod(this,'ReallyRefreshContents','','',arguments);
}
self.AnalyzeThis_ThirdParty_AbstractAmChart__Loader = function() {
	zenLoadClass('_ZEN_Component_component');
	AnalyzeThis_ThirdParty_AbstractAmChart.prototype = zenCreate('_ZEN_Component_component',-1);
	var p = AnalyzeThis_ThirdParty_AbstractAmChart.prototype;
	if (null==p) {return;}
	p.constructor = AnalyzeThis_ThirdParty_AbstractAmChart;
	p.superClass = ('undefined' == typeof _ZEN_Component_component) ? zenMaster._ZEN_Component_component.prototype:_ZEN_Component_component.prototype;
	p.__ZENcomponent = true;
	p._serverClass = 'AnalyzeThis.ThirdParty.AbstractAmChart';
	p._type = 'AbstractAmChart';
	p.serialize = AnalyzeThis_ThirdParty_AbstractAmChart_serialize;
	p.getSettings = AnalyzeThis_ThirdParty_AbstractAmChart_getSettings;
	p.GetListingSql = AnalyzeThis_ThirdParty_AbstractAmChart_GetListingSql;
	p.JavaInstalled = AnalyzeThis_ThirdParty_AbstractAmChart_JavaInstalled;
	p.LoadZenComponent = AnalyzeThis_ThirdParty_AbstractAmChart_LoadZenComponent;
	p.MonitorBackgroundTask = AnalyzeThis_ThirdParty_AbstractAmChart_MonitorBackgroundTask;
	p.ReallyRefreshContents = AnalyzeThis_ThirdParty_AbstractAmChart_ReallyRefreshContents;
	p.adjustContentSize = AnalyzeThis_ThirdParty_AbstractAmChart_adjustContentSize;
	p.connectToController = AnalyzeThis_ThirdParty_AbstractAmChart_connectToController;
	p.disconnectFromController = AnalyzeThis_ThirdParty_AbstractAmChart_disconnectFromController;
	p.getConnectedController = AnalyzeThis_ThirdParty_AbstractAmChart_getConnectedController;
	p.getController = AnalyzeThis_ThirdParty_AbstractAmChart_getController;
	p.notifyView = AnalyzeThis_ThirdParty_AbstractAmChart_notifyView;
	p.notifyViewHandler = AnalyzeThis_ThirdParty_AbstractAmChart_notifyViewHandler;
	p.renderSameParts = AnalyzeThis_ThirdParty_AbstractAmChart_renderSameParts;
	p.sendEventToController = AnalyzeThis_ThirdParty_AbstractAmChart_sendEventToController;
	p.setControllerId = AnalyzeThis_ThirdParty_AbstractAmChart_setControllerId;
}

self._zenClassIdx['AmSmoothedLineChart'] = 'AnalyzeThis_ThirdParty_AmSmoothedLineChart';
self.AnalyzeThis_ThirdParty_AmSmoothedLineChart = function(index,id) {
	if (index>=0) {AnalyzeThis_ThirdParty_AmSmoothedLineChart__init(this,index,id);}
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart__init = function(o,index,id) {
	('undefined' == typeof AnalyzeThis_ThirdParty_AbstractAmChart__init) ?zenMaster.AnalyzeThis_ThirdParty_AbstractAmChart__init(o,index,id):AnalyzeThis_ThirdParty_AbstractAmChart__init(o,index,id);
	o.controller = '';
	o.controllerId = '';
	o.ongetcontroller = '';
	o.onnotifyView = '';
	o.useSoftModals = true;
}
function AnalyzeThis_ThirdParty_AmSmoothedLineChart_serialize(set,s)
{
	var o = this;s[0]='604339197';s[1]=o.index;s[2]=o.id;s[3]=o.name;s[4]=set.addObject(o.parent,'parent');s[5]=set.addObject(o.composite,'composite');s[6]=o.SVGClassList;s[7]=o.UserSVGPackageList;s[8]=o.align;s[9]=o.aux;s[10]=o.backgroundTimerInterval;s[11]=o.barColor;s[12]=o.captions;s[13]=(o.captionsFromSource?1:0);s[14]=o.cellAlign;s[15]=o.cellSize;s[16]=o.cellStyle;s[17]=o.cellVAlign;s[18]=set.serializeList(o,o.children,true,'children');s[19]=o.containerStyle;s[20]=o.controller;s[21]=o.controllerId;s[22]=o.cssLevel;s[23]=(o.designMode?1:0);s[24]=(o.disabled?1:0);s[25]=(o.dragAndDrop?1:0);s[26]=(o.dragEnabled?1:0);s[27]=(o.dropEnabled?1:0);s[28]=(o.dynamic?1:0);s[29]=(o.enableListing?1:0);s[30]=o.enclosingClass;s[31]=o.enclosingStyle;s[32]=o.error;s[33]=o.groupClass;s[34]=o.groupStyle;s[35]=o.height;s[36]=(o.hidden?1:0);s[37]=o.hint;s[38]=o.hintClass;s[39]=o.hintStyle;s[40]=o.hintText;s[41]=(o.inlineSVG?1:0);s[42]=(o.isPopup?1:0);s[43]=(o.isSoftModal?1:0);s[44]=o.label;s[45]=o.labelClass;s[46]=o.labelDisabledClass;s[47]=o.labelPosition;s[48]=o.labelStyle;s[49]=o.lastModalIndex;s[50]=o.layout;s[51]=o.nextIndex;s[52]=o.onafterdrag;s[53]=o.onbeforedrag;s[54]=o.onclick;s[55]=o.ondrag;s[56]=o.ondrop;s[57]=o.ongetcontroller;s[58]=o.onhide;s[59]=o.onnotifyView;s[60]=o.onoverlay;s[61]=o.onrefresh;s[62]=o.onshow;s[63]=o.onupdate;s[64]=o.overlayMode;s[65]=(o.pager?1:0);s[66]=o.popupParent;s[67]=o.renderFlag;s[68]=(o.showLabel?1:0);s[69]=o.slice;s[70]=o.title;s[71]=o.tuple;s[72]=(o.useSVG?1:0);s[73]=(o.useSoftModals?1:0);s[74]=o.valign;s[75]=(o.visible?1:0);s[76]=o.width;s[77]=(o.zenPersistentPopup?1:0);
}
function AnalyzeThis_ThirdParty_AmSmoothedLineChart_getSettings(s)
{
	s['name'] = 'string';
	s['controllerId'] = 'id';
	s['ongetcontroller'] = 'eventHandler';
	s['onnotifyView'] = 'eventHandler';
	this.invokeSuper('getSettings',arguments);
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_acquireData = function() {
var controller = this.getConnectedController();
if (!controller) return;
var isPivot = controller.getSelectedRange;
if (!isPivot) {
var labelDim = 2;
var seriesSize = controller.getDimSize(1);
var seriesCount = controller.getDimSize(2);
} else {
var labelDim = 1;
var seriesSize = controller.getDimSize(2);
var seriesCount = controller.getDimSize(1);
}
var props = [];
for(var yearVal=0;yearVal <  seriesCount;yearVal++) {
var propName = controller.getLabel(yearVal,labelDim);
if (!isPivot && propName.charAt(0) == '%') continue;  // KPI special columns
props[yearVal] = {name: propName}
props[yearVal].val=controller.getData(yearVal,0);
}
console.log(props);
return props;
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_connectToController = function() {
this.controller = '';
if (!zenIsMissing(this.controllerId)) {
if (this.composite) {
this.controller = this.composite.getChildById(this.controllerId);
}
else {
this.controller = zenPage.getComponentById(this.controllerId);
}
if (this.controller && this.controller.register) {
this.controller.register(this);
}
else {
alert('ZEN: Unable to connect component to dataController (' + this.id + ').');
}
if (this.controller) {
if ('' == this.controller.modelError) {
this.controller.loadModel(false);
}
}
}
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_disconnectFromController = function() {
if (this.controller && this.controller.unregister) {
this.controller.unregister(this);
}
this.controller = '';
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_getController = function() {
if (this.ongetcontroller) {
return zenInvokeCallbackMethod(this.ongetcontroller,this,'ongetcontroller','view',this);
}
return (null == this.controller || '' == this.controller) ? null : this.controller;
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_notifyView = function(reason,data1,data2,data3) {
var ret = true;
if (this.onnotifyView) {
ret = zenInvokeCallbackMethod(this.onnotifyView,this,'onnotifyEvent','reason',reason,'data1',data1,'data2',data2,'data3',data3);
}
if (ret && this.notifyViewHandler) {
this.notifyViewHandler(reason,data1,data2,data3);
}
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_renderContents = function() {
this.renderSameParts(this);
var chart = new AmCharts.AmSerialChart();
var chartData=this.acquireData();
chart.pathToImages = "http://www.amcharts.com/lib/3/images/";
chart.dataProvider = chartData;
chart.marginLeft = 10;
chart.categoryField = "name";
chart.addListener("dataUpdated", zoomChart);
var categoryAxis = chart.categoryAxis;
categoryAxis.dashLength = 3;
categoryAxis.minorGridEnabled = true;
categoryAxis.minorGridAlpha = 0.1;
var valueAxis = new AmCharts.ValueAxis();
valueAxis.axisAlpha = 0;
valueAxis.inside = true;
valueAxis.dashLength = 3;
chart.addValueAxis(valueAxis);
graph = new AmCharts.AmGraph();
graph.type = "smoothedLine"; // this line makes the graph smoothed line.
graph.lineColor = "#d1655d";
graph.negativeLineColor = "#637bb6"; // this line makes the graph to change color when it drops below 0
graph.lineThickness = 2;
graph.valueField = "val";
graph.balloonText = "[[value]]";
chart.addGraph(graph);
var chartCursor = new AmCharts.ChartCursor();
chartCursor.cursorAlpha = 0;
chartCursor.cursorPosition = "mouse";
chart.addChartCursor(chartCursor);
var chartScrollbar = new AmCharts.ChartScrollbar();
chart.addChartScrollbar(chartScrollbar);
chart.write("amchart"+this.index);
this.chart=chart;
var temppivot = this.getConnectedController(); //need this @clickGraphItem event
chart.addListener("zoomed",
function (event) {
console.log(event);
temppivot.selectCellRange(event.startIndex+1,0,event.endIndex+1,0);
}
);
function zoomChart() {
chart.zoomToIndexes(0,100);
}
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_sendEventToController = function(reason,data1,data2,data3) {
var controller = this.getController();
if (controller && controller.notifyController) {
controller.notifyController(this,reason,data1,data2,data3);
}
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_setControllerId = function(id) {
this.disconnectFromController();
this.controllerId = id;
this.connectToController();
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_GetListingSql = function(inMDX,inrange) {
	zenClassMethod(this,'GetListingSql','L,L','',arguments);
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_JavaInstalled = function() {
	return zenClassMethod(this,'JavaInstalled','','BOOLEAN',arguments);
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_LoadZenComponent = function(pNamespace,pName,pClassName,pCSSLevel) {
	return zenClassMethod(this,'LoadZenComponent','L,L,L,L','BOOLEAN',arguments);
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_MonitorBackgroundTask = function(pTaskID) {
	zenClassMethod(this,'MonitorBackgroundTask','L','',arguments);
}

self.AnalyzeThis_ThirdParty_AmSmoothedLineChart_ReallyRefreshContents = function() {
	zenInstanceMethod(this,'ReallyRefreshContents','','',arguments);
}
self.AnalyzeThis_ThirdParty_AmSmoothedLineChart__Loader = function() {
	zenLoadClass('AnalyzeThis_ThirdParty_AbstractAmChart');
	AnalyzeThis_ThirdParty_AmSmoothedLineChart.prototype = zenCreate('AnalyzeThis_ThirdParty_AbstractAmChart',-1);
	var p = AnalyzeThis_ThirdParty_AmSmoothedLineChart.prototype;
	if (null==p) {return;}
	p.constructor = AnalyzeThis_ThirdParty_AmSmoothedLineChart;
	p.superClass = ('undefined' == typeof AnalyzeThis_ThirdParty_AbstractAmChart) ? zenMaster.AnalyzeThis_ThirdParty_AbstractAmChart.prototype:AnalyzeThis_ThirdParty_AbstractAmChart.prototype;
	p.__ZENcomponent = true;
	p._serverClass = 'AnalyzeThis.ThirdParty.AmSmoothedLineChart';
	p._type = 'AmSmoothedLineChart';
	p.serialize = AnalyzeThis_ThirdParty_AmSmoothedLineChart_serialize;
	p.getSettings = AnalyzeThis_ThirdParty_AmSmoothedLineChart_getSettings;
	p.GetListingSql = AnalyzeThis_ThirdParty_AmSmoothedLineChart_GetListingSql;
	p.JavaInstalled = AnalyzeThis_ThirdParty_AmSmoothedLineChart_JavaInstalled;
	p.LoadZenComponent = AnalyzeThis_ThirdParty_AmSmoothedLineChart_LoadZenComponent;
	p.MonitorBackgroundTask = AnalyzeThis_ThirdParty_AmSmoothedLineChart_MonitorBackgroundTask;
	p.ReallyRefreshContents = AnalyzeThis_ThirdParty_AmSmoothedLineChart_ReallyRefreshContents;
	p.acquireData = AnalyzeThis_ThirdParty_AmSmoothedLineChart_acquireData;
	p.connectToController = AnalyzeThis_ThirdParty_AmSmoothedLineChart_connectToController;
	p.disconnectFromController = AnalyzeThis_ThirdParty_AmSmoothedLineChart_disconnectFromController;
	p.getController = AnalyzeThis_ThirdParty_AmSmoothedLineChart_getController;
	p.notifyView = AnalyzeThis_ThirdParty_AmSmoothedLineChart_notifyView;
	p.renderContents = AnalyzeThis_ThirdParty_AmSmoothedLineChart_renderContents;
	p.sendEventToController = AnalyzeThis_ThirdParty_AmSmoothedLineChart_sendEventToController;
	p.setControllerId = AnalyzeThis_ThirdParty_AmSmoothedLineChart_setControllerId;
}

self._zenClassIdx['http://www.intersystems.com/deepsee/NVD3timeChart'] = 'AnalyzeThis_ThirdParty_NVD3timeChart';
self.AnalyzeThis_ThirdParty_NVD3timeChart = function(index,id) {
	if (index>=0) {AnalyzeThis_ThirdParty_NVD3timeChart__init(this,index,id);}
}

self.AnalyzeThis_ThirdParty_NVD3timeChart__init = function(o,index,id) {
	('undefined' == typeof _DeepSee_Component_Portlet_abstractPortlet__init) ?zenMaster._DeepSee_Component_Portlet_abstractPortlet__init(o,index,id):_DeepSee_Component_Portlet_abstractPortlet__init(o,index,id);
	o.backgroundTimerInterval = '1000';
	o.cellAlign = '';
	o.cellSize = '';
	o.cellStyle = '';
	o.cellVAlign = 'top';
	o.controller = '';
	o.controllerId = '';
	o.cssLevel = '2';
	o.designMode = false;
	o.disabled = false;
	o.dragAndDrop = false;
	o.groupClass = 'page';
	o.groupStyle = '';
	o.inlineSVG = false;
	o.labelPosition = 'top';
	o.lastModalIndex = '0';
	o.layout = ''; // encrypted
	o.nextIndex = '0';
	o.ongetcontroller = '';
	o.onnotifyView = '';
	o.useSVG = false;
	o.useSoftModals = true;
	o.zenPersistentPopup = false;
}
function AnalyzeThis_ThirdParty_NVD3timeChart_serialize(set,s)
{
	var o = this;s[0]='2814263480';s[1]=o.index;s[2]=o.id;s[3]=o.name;s[4]=set.addObject(o.parent,'parent');s[5]=set.addObject(o.composite,'composite');s[6]=o.SVGClassList;s[7]=o.UserSVGPackageList;s[8]=o.align;s[9]=o.aux;s[10]=o.backgroundTimerInterval;s[11]=o.cellAlign;s[12]=o.cellSize;s[13]=o.cellStyle;s[14]=o.cellVAlign;s[15]=set.serializeList(o,o.children,true,'children');s[16]=o.containerStyle;s[17]=o.controller;s[18]=o.controllerId;s[19]=o.cssLevel;s[20]=(o.designMode?1:0);s[21]=(o.disabled?1:0);s[22]=(o.dragAndDrop?1:0);s[23]=(o.dragEnabled?1:0);s[24]=(o.dropEnabled?1:0);s[25]=(o.dynamic?1:0);s[26]=o.enclosingClass;s[27]=o.enclosingStyle;s[28]=o.error;s[29]=o.groupClass;s[30]=o.groupStyle;s[31]=o.height;s[32]=(o.hidden?1:0);s[33]=o.hint;s[34]=o.hintClass;s[35]=o.hintStyle;s[36]=(o.inlineSVG?1:0);s[37]=(o.isPopup?1:0);s[38]=(o.isSoftModal?1:0);s[39]=o.label;s[40]=o.labelClass;s[41]=o.labelDisabledClass;s[42]=o.labelPosition;s[43]=o.labelStyle;s[44]=o.lastModalIndex;s[45]=o.layout;s[46]=o.nextIndex;s[47]=o.onafterdrag;s[48]=o.onbeforedrag;s[49]=o.onclick;s[50]=o.ondrag;s[51]=o.ondrop;s[52]=o.ongetcontroller;s[53]=o.onhide;s[54]=o.onnotifyView;s[55]=o.onoverlay;s[56]=o.onrefresh;s[57]=o.onshow;s[58]=o.onupdate;s[59]=o.overlayMode;s[60]=o.popupParent;s[61]=o.renderFlag;s[62]=(o.showLabel?1:0);s[63]=o.slice;s[64]=o.title;s[65]=o.tuple;s[66]=(o.useSVG?1:0);s[67]=(o.useSoftModals?1:0);s[68]=o.valign;s[69]=(o.visible?1:0);s[70]=o.width;s[71]=(o.zenPersistentPopup?1:0);
}
function AnalyzeThis_ThirdParty_NVD3timeChart_getSettings(s)
{
	s['name'] = 'string';
	s['controllerId'] = 'id';
	s['ongetcontroller'] = 'eventHandler';
	s['onnotifyView'] = 'eventHandler';
	this.invokeSuper('getSettings',arguments);
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_connectToController = function() {
this.controller = '';
if (!zenIsMissing(this.controllerId)) {
if (this.composite) {
this.controller = this.composite.getChildById(this.controllerId);
}
else {
this.controller = zenPage.getComponentById(this.controllerId);
}
if (this.controller && this.controller.register) {
this.controller.register(this);
}
else {
alert('ZEN: Unable to connect component to dataController (' + this.id + ').');
}
if (this.controller) {
if ('' == this.controller.modelError) {
this.controller.loadModel(false);
}
}
}
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_disconnectFromController = function() {
if (this.controller && this.controller.unregister) {
this.controller.unregister(this);
}
this.controller = '';
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_getController = function() {
if (this.ongetcontroller) {
return zenInvokeCallbackMethod(this.ongetcontroller,this,'ongetcontroller','view',this);
}
return (null == this.controller || '' == this.controller) ? null : this.controller;
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_notifyView = function(reason,data1,data2,data3) {
var ret = true;
if (this.onnotifyView) {
ret = zenInvokeCallbackMethod(this.onnotifyView,this,'onnotifyEvent','reason',reason,'data1',data1,'data2',data2,'data3',data3);
}
if (ret && this.notifyViewHandler) {
this.notifyViewHandler(reason,data1,data2,data3);
}
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_sendEventToController = function(reason,data1,data2,data3) {
var controller = this.getController();
if (controller && controller.notifyController) {
controller.notifyController(this,reason,data1,data2,data3);
}
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_setControllerId = function(id) {
this.disconnectFromController();
this.controllerId = id;
this.connectToController();
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_JavaInstalled = function() {
	return zenClassMethod(this,'JavaInstalled','','BOOLEAN',arguments);
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_LoadZenComponent = function(pNamespace,pName,pClassName,pCSSLevel) {
	return zenClassMethod(this,'LoadZenComponent','L,L,L,L','BOOLEAN',arguments);
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_MonitorBackgroundTask = function(pTaskID) {
	zenClassMethod(this,'MonitorBackgroundTask','L','',arguments);
}

self.AnalyzeThis_ThirdParty_NVD3timeChart_ReallyRefreshContents = function() {
	zenInstanceMethod(this,'ReallyRefreshContents','','',arguments);
}
self.AnalyzeThis_ThirdParty_NVD3timeChart__Loader = function() {
	zenLoadClass('_DeepSee_Component_Portlet_abstractPortlet');
	AnalyzeThis_ThirdParty_NVD3timeChart.prototype = zenCreate('_DeepSee_Component_Portlet_abstractPortlet',-1);
	var p = AnalyzeThis_ThirdParty_NVD3timeChart.prototype;
	if (null==p) {return;}
	p.constructor = AnalyzeThis_ThirdParty_NVD3timeChart;
	p.superClass = ('undefined' == typeof _DeepSee_Component_Portlet_abstractPortlet) ? zenMaster._DeepSee_Component_Portlet_abstractPortlet.prototype:_DeepSee_Component_Portlet_abstractPortlet.prototype;
	p.__ZENcomponent = true;
	p._serverClass = 'AnalyzeThis.ThirdParty.NVD3timeChart';
	p._type = 'NVD3timeChart';
	p.serialize = AnalyzeThis_ThirdParty_NVD3timeChart_serialize;
	p.getSettings = AnalyzeThis_ThirdParty_NVD3timeChart_getSettings;
	p.JavaInstalled = AnalyzeThis_ThirdParty_NVD3timeChart_JavaInstalled;
	p.LoadZenComponent = AnalyzeThis_ThirdParty_NVD3timeChart_LoadZenComponent;
	p.MonitorBackgroundTask = AnalyzeThis_ThirdParty_NVD3timeChart_MonitorBackgroundTask;
	p.ReallyRefreshContents = AnalyzeThis_ThirdParty_NVD3timeChart_ReallyRefreshContents;
	p.connectToController = AnalyzeThis_ThirdParty_NVD3timeChart_connectToController;
	p.disconnectFromController = AnalyzeThis_ThirdParty_NVD3timeChart_disconnectFromController;
	p.getController = AnalyzeThis_ThirdParty_NVD3timeChart_getController;
	p.notifyView = AnalyzeThis_ThirdParty_NVD3timeChart_notifyView;
	p.sendEventToController = AnalyzeThis_ThirdParty_NVD3timeChart_sendEventToController;
	p.setControllerId = AnalyzeThis_ThirdParty_NVD3timeChart_setControllerId;
}
/* EOF */