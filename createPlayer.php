<?php
session_start();
require("transferportaldb.php");

if (isset($_SESSION['userID']) && hasPlayer($_SESSION['userID'])) {
    header("Location: dashboard.php");
    exit();
}

if (!isset($_SESSION['userID'])){
    header("Location: login.php");
    exit();
}

?>
<!DOCTYPE html>
<html>
<head>
    <title>Transfer Portal</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>
    <div class="login-container">
        <h2>Transfer Portal Player Creation</h2>
        <form method="post" action="index.php">
            <div class="form-group">
                <p>Generated PlayerID: <?php echo 999 . $_SESSION['userID']; ?></p>
                
                <label>Player Name</label>
                <input type="text" name="Playername" pattern="[A-Za-z\s]+" required>
            </div>
            <div class="form-group">
                <label>Hometown</label>
                <input type="text" name="Playerhometown" pattern="[A-Za-z\s]+" required>
            </div>
            <div class="form-group">
                <label>Position</label>
                <select name="position" required id="PositionSelector">
                    <option value="" selected>Select Position</option>
                    <option value="Quarterback">Quarterback</option>
                    <option value="Runningback">Running Back</option>
                    <option value="Widereceiver">Wide Receiver</option>
                    <option value="Safety">Safety</option>
                    <option value="Linebacker">Linebacker</option>
                    <option value="Kicker">Kicker</option>
                </select>
            </div>
            <div class="form-group" id="positionStats">
                <div id="Quarterback" class="hidden">
                    <p><strong>Quarterback Stats:</strong></p>
                        <label for="QBPY">Passing Yards</label>
                        <input type="number" name="passingYards" id="QBPY" min="0" max="100" step=".5">
                        
                        <label for="QBPP">Passing Percentage</label>
                        <input type="number" name="passingPercentage" id="QBPP" min="0" max=".3" step=".01">
                        <label for="QBT">Touchdowns</label>   
                        <input type="number" name="touchdowns" id="QBT" min="0" max="5" step="1">
                        
                        <label for="QBI">Interceptions</label>
                        <input type="number" name="interceptions" id="QBI" min="0" max="10" step="1">
                    </div>

                <div id="Runningback" class="hidden">
                    <p><strong>Runningback Stats:</strong></p>
                        <label for="RB_LR">Longest Run</label>
                        <input type="number" name="longestRun" id="RB_LR" min="0" max="110" step=".5">
                        
                        <label for="RB_T">Touchdowns</label>   
                        <input type="number" name="touchdowns" id="RB_T" min="0" max="5" step="1">
                        
                        <label for="RB_C">Carries</label>
                        <input type="number" name="carries" id="RB_C" min="0" max="10" step="1">
                        
                        
                        <label for="RB_Y">Total Yards</label>
                        <input type="number" name="yards" id="RB_Y" min="0" max="300" step=".5">
                </div>
                
                <div id="Widereceiver" class="hidden">
                    <p><strong>Wide Receiver Stats:</strong></p>
                        
                        <label for="WR_R">Receptions</label>
                        <input type="number" name="receptions" id="WR_R" min="0" max="25" step="1">
                        
                        <label for="WR_Y">Total Yards</label>
                        <input type="number" name="yards" id="WR_Y" min="0" max="300" step=".5">
                        
                        <label for="WR_T">Touchdowns</label>   
                        <input type="number" name="touchdowns" id="WR_T" min="0" max="5" step="1">
                        
                        <label for="WR_LR">Longest Reception</label>
                        <input type="number" name="longestReception" id="WR_LR" min="0" max="110" step=".5">
                </div>

                <div id="Safety" class="hidden">
                    <p><strong>Safety Stats:</strong></p>
                        
                        <label for="S_SS">Solo Tackles</label>
                        <input type="number" name="solo_tackles" id="S_SS" min="0" max="15" step="1">
                        
                        <label for="S_TT">Total Tackles</label>   
                        <input type="number" name="total_tackles" id="S_TT" min="0" max="20" step="1">
                        
                        <label for="S_I">Interceptions</label>
                        <input type="number" name="interceptions" id="S_I" min="0" max="10" step="1">
                        
                        
                        <label for="S_PD">Passes Deflected</label>
                        <input type="number" name="passes_defended" id="S_PD" min="0" max="20" step="1">
                </div>
                
                <div id="Linebacker" class="hidden">
                    <p><strong>Linebacker Stats:</strong></p>
                        
                        <label for="LB_S">Sacks</label>
                        <input type="number" name="sacks" id="LB_S" min="0" max="10" step="1">
                        
                        <label for="LB_TFL">Tackles For Loss</label>   
                        <input type="number" name="tackles_for_loss" id="LB_TFL" min="0" max="5" step="1">
                        
                        <label for="LB_TT">Total Tackles</label>
                        <input type="number" name="total_tackles" id="LB_TT" min="0" max="20" step="1">
                        
                        
                        <label for="LB_ST">Solo Tackles</label>
                        <input type="number" name="solo_tackles" id="LB_ST" min="0" max="15" step="1">
                </div>

                <div id="Kicker" class="hidden">
                    <p><strong>Kicker Stats:</strong></p>
                        
                        <label for="K_LK">Longest Kick</label>
                        <input type="number" name="longest" id="K_LK" min="0" max="50" step=".5">
                        
                        <label for="K_FA">FG Attempted</label>   
                        <input type="number" name="fg_attempted" id="K_FA" min="0" max="15" step="1">
                        
                        <label for="K_FM">FG Made</label>
                        <input type="number" name="fg_made" id="K_FM" min="0" max="15" step="1">
                        
                        
                        <label for="K_P">Points</label>
                        <input type="number" name="points" id="K_P" min="0" max="45" step="1">
                </div>
                
            </div>
            <button type='submit' name="CreatePlayer" style="margin-top: 10px;">Create Player</button>
        </form>
    </div>
</body>
<script src="positionStats.js"></script>
</html>
