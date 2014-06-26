$(document).ready(function()
{
	// Calendario
	Calendar.setup({
		inputField : "from_date",
		trigger    : "from_date_trigger",
		showTime   : true,
		weekNumbers   : false,
		align         : "Bl/ / /T/r",
		selectionType : Calendar.SEL_SINGLE,
		selection     : Calendar.dateToInt(new Date()),
		showTime      : 24,
		onSelect      : function() {},
		onTimeChange  : function(cal) {
			var h = cal.getHours(), m = cal.getMinutes();
			if (h < 10) h = "0" + h;
			if (m < 10) m = "0" + m;
			var dateActual = $("#from_date").val();
			$("#from_date").val(dateActual.substring(0,10)+" "+h+":"+m+":00");
		}
	});


	// Calendario
	Calendar.setup({
		inputField : "to_date",
		trigger    : "to_date_trigger",
		showTime   : true,
		weekNumbers   : false,
		align         : "Bl/ / /T/r",
		selectionType : Calendar.SEL_SINGLE,
		selection     : Calendar.dateToInt(new Date()),
		showTime      : 24,
		onSelect      : function() {},
		onTimeChange  : function(cal) {
			var h = cal.getHours(), m = cal.getMinutes();
			if (h < 10) h = "0" + h;
			if (m < 10) m = "0" + m;
			var dateActual = $("#from_date").val();
			$("#to_date").val(dateActual.substring(0,10)+" "+h+":"+m+":00");
		}
	});

});