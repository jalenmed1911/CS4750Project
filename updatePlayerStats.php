<?php
    session_start();
    require("transferportaldb.php");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    require("positionStats.php");
    header('Content-Type: application/json');



    

    $response = [
        "success" => false,
        "error" => null,
        "data" => null
    ];

    try{
        if (!isset($_SESSION['userID'])) {
            throw new Exception("Not authenticated");
        }
        $userID = $_SESSION['userID'];

        $myPlayer = getUserPlayers($userID);
        if (!$myPlayer) {
            throw new Exception("Player not found");
        }
        $pos_abbr = $myPlayer['position'];

        $config = $positionStats[$pos_abbr];
        if (!isset($config) || !is_array($config)) {
            throw new Exception("Invalid config");
        }
        $statsMap = $config['stats'];


        // Get playerID, position, stats
        $playerID = $myPlayer['playerID'];
        $stats = getStatsByPlayer($playerID);
        //pos_abbr is already defined above as $pos_abbr



        // Get table name
        $tableMap = [
            'QB' => 'Quarterback',
            'RB' => 'Running_Back',
            'WR' => 'Wide_Receiver',
            'LB' => 'Linebacker',
            'S'  => 'Safety',
            'K'  => 'Kicker'
        ];

        if (!isset($tableMap[$pos_abbr])) {
            throw new Exception("Invalid position");
        }

        $table = $tableMap[$pos_abbr];


        // Calculate new stats
        $newStats = calculateNewStats($stats, $statsMap);

        // Validate new stats
        if (empty($newStats)) {
            throw new Exception("No stats to update");
        }

        // Build UPDATE query
        $setClauses = [];
        foreach ($newStats as $col => $val) {
            $setClauses[] = "$col = :$col";
        }
        $query = "UPDATE $table SET " . implode(', ', $setClauses) . " WHERE playerID = :playerID";

        // Execute
        $stmt = $db->prepare($query);
        $stmt->bindValue(':playerID', $playerID);
        foreach ($newStats as $col => $val) {
            $stmt->bindValue(":$col", $val);
        }
        $stmt->execute();
        $stmt->closeCursor();
        $response["success"] = true;
    } catch (Exception $e) {
        $response["success"] = false;
        $response["error"] = $e->getMessage();
    }    

    echo json_encode($response);
    exit();

    
                            
?>  