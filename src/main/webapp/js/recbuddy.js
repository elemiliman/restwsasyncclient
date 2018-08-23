function setUploadStatusText(text){
	$("#profile-photo-status").text(text);
	
	window.setTimeout(function(){
		$("#profile-photo-status").text("");
	},5000);
	
}

function uploadSuccess(data){
	
	setUploadStatusText(data.message);
	
	location.reload();
	
	$("#photoFileInput").val("");
}
	

function uploadPhoto(event){
	
	$.ajax({
		url: $(this).attr("action"),
		type: 'POST',
		data: new FormData(this),
		processData: false,
		contentType: false,
		success: uploadSuccess,
		error: function(){
			setUploadStatusText("Server unreachable");
		}
		
	});
	
	event.preventDefault();
}

$(document).ready(function(){
	
	$("#uploadLink").click(function(event){
		event.preventDefault();
		$("#photoFileInput").trigger('click')
	});
	
	$("#photoFileInput").change(function(){
		$("#photoUploadForm").submit();
	});
	
	$("#photoUploadForm").on("submit", uploadPhoto);
});