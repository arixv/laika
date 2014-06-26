$(document).ready(function(){

	Calendar.setup({
		inputField : "calendar-field",
		trigger    : "calendar-trigger",
		showTime   : true,
		weekNumbers   : false,
		align         : "Br/ / /T/r",
		selectionType : Calendar.SEL_SINGLE,
		selection     : Calendar.dateToInt(new Date()),
		showTime      : 24,
		//	onSelect   : function() { this.hide() }
		onSelect      : function() {
			
		},
		onTimeChange  : function(cal) {
			var h = cal.getHours(), m = cal.getMinutes();
			// zero-pad them
			if (h < 10) h = "0" + h;
			if (m < 10) m = "0" + m;
			var dateActual = $("#calendar-field").val();
			$("#calendar-field").val(dateActual.substring(0,10)+" "+h+":"+m+":00");
		}
	});
});

