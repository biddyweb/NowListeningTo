<?php

	function connect(){
		$username = "asandboxcomar";
		$password = "b^pgFqjm";
		$database = "nltapp";
		$host = "mysql.asandbox.com.ar";
		mysql_connect($host,$username,$password);
		@mysql_select_db($database);
	}

	function disconnect(){
		mysql_close();
	}

	function addTimelineEntry($userUDID, $songTitle, $songArtist){

		//	Get userId
		$user = getUserForOpenUDID($userUDID);
		$userId = -1;
		
		if ($user){
			$userId = $user['id'];
		}else{
			$userId = insertUser($userUDID);
		}

		//	Get song
		$song = getSongForTitleAndArtist($songTitle, $songArtist);
		$songId = -1;

		if ($song){
			$songId = $song['id'];

		}else{
			//	Check if theres an artist for that
			$artist = getArtistForTitle($songArtist);
			$artistId = -1;

			if ($artist){
				//	You've got the artistId, yay
				$artistId = $artist['id'];
			}else{
				//	You don't have an artist. So you'll have to create it
				$artistId = insertArtist($songArtist);
			}

			$songId = insertSongWithArtistId($songTitle, $artistId);
		}

		$retVal = insertTimelineEntry($songId, $userId);		
		return $retVal;
	}

	function insertTimelineEntry($songId, $userId){
		connect();

		$query = sprintf("INSERT INTO timelines (songId, userId) VALUES ('%s', '%s')", $songId, $userId);
		$retVal = mysql_query($query);

		$lastId = mysql_insert_id();

		disconnect();

		return $lastId;
	}

	function getUserForOpenUDID($openUDID){
		connect();

		$query = sprintf("SELECT * FROM users WHERE openudid = '%s'", $openUDID);
		$result = mysql_query($query);
		$retVal = mysql_fetch_array($result, MYSQL_ASSOC);

		disconnect();

		return $retVal;
	}

	function getSongForTitleAndArtist($songTitle, $songArtist){
		connect();

		$query = sprintf("SELECT * FROM songs INNER JOIN artists ON songs.artistId = artists.id WHERE songs.title = '%s' AND artists.title = '%s'", $songTitle, $songArtist);
		$result = mysql_query($query);
		$retVal = mysql_fetch_array($result, MYSQL_ASSOC);

		disconnect();

		return $retVal;
	}

	function getArtistForTitle($songArtist){
		connect();

		$query = sprintf("SELECT * FROM artists WHERE title = '%s'", $songArtist);
		$result = mysql_query($query);
		$retVal = mysql_fetch_array($result, MYSQL_ASSOC);

		disconnect();

		return $retVal;
	}

	function insertArtist($songArtist){
		connect();

		$query = sprintf("INSERT INTO artists (title) VALUES ('%s')", $songArtist);
		$result = mysql_query($query);

		$lastId = mysql_insert_id();

		disconnect();

		return $lastId;
	}

	function insertSongWithArtistId($songTitle, $artistId){
		connect();

		$query = sprintf("INSERT INTO songs (title, artistId) VALUES ('%s', %d)", $songTitle, $artistId);

		$result = mysql_query($query);

		$lastId = mysql_insert_id();

		disconnect();

		return $lastId;
	}

	function insertUser($openUDID, $username){
		connect();

		$query = sprintf("INSERT INTO users (openudid, username) VALUES ('%s', '%s')", $openUDID, $username);
		$result = mysql_query($query);
		
		$lastId = mysql_insert_id();

		disconnect();

		return $lastId;
	}

?>