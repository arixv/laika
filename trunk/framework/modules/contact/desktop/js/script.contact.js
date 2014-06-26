

$(document).ready(function()
{
	// Calendario
	Calendar.setup({
		inputField : "calendar-field-start",
		trigger    : "calendar-trigger-start",
		showTime   : true,
		weekNumbers   : false,
		align         : "Bl/ / /T/r",
		selectionType : Calendar.SEL_SINGLE,
		selection     : Calendar.dateToInt(new Date()),
		showTime      : 24,
		//	onSelect   : function() { this.hide() }
		onSelect      : function() {},
		onTimeChange  : function(cal) {
				var h = cal.getHours(), m = cal.getMinutes();
				// zero-pad them
				if (h < 10) h = "0" + h;
				if (m < 10) m = "0" + m;
				var dateActual = $("#calendar-field-start").val();
				$("#calendar-field-start").val(dateActual.substring(0,10)+" "+h+":"+m+":00");
			}
	});


	Calendar.setup({
		inputField : "calendar-field-end",
		trigger    : "calendar-trigger-end",
		showTime   : true,
		weekNumbers   : false,
		align         : "Bl/ / /T/r",
		selectionType : Calendar.SEL_SINGLE,
		selection     : Calendar.dateToInt(new Date()),
		showTime      : 24,
		//	onSelect   : function() { this.hide() }
		onSelect      : function() {},
		onTimeChange  : function(cal) {
				var h = cal.getHours(), m = cal.getMinutes();
				// zero-pad them
				if (h < 10) h = "0" + h;
				if (m < 10) m = "0" + m;
				var dateActual = $("#calendar-field-end").val();
				$("#calendar-field-end").val(dateActual.substring(0,10)+" "+h+":"+m+":00");
			}
	});


});