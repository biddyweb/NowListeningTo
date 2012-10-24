<?php
	include 'db.php';

	if ($_REQUEST['action'] == "add"){
		$user = $_REQUEST['user'];
		$song = $_REQUEST['song'];
		$artist = $_REQUEST['artist'];

		
		if ($user && $song && $artist){
			$id = addTimelineEntry($user, $song, $artist);
			
			if ($id){
				echo '{"message" : "posted successfully to #NLTApp"}';
			}else{
				echo '{"error" : "something went wrong"}';
			}
		}else{
			echo '{"error" : "bad request"}'; 
		}

	}else{
		echo ("Hello");
	}

?>