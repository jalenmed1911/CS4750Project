<?php
session_start();
require("transferportaldb.php");

if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit();
}
$username = $_SESSION['user'];

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Player Management - Transfer Portal</title>
    <link rel="stylesheet" href="dashboard.css">
    <style>
        
    </style>
</head>
<body>
    <nav class="top-nav">
        <div class="brand">Fantasy Football Portal</div>
        <div class="user-menu">
            <span>Welcome, <a href="profile.php" style="text-decoration: none; color: inherit;"><strong><?php echo htmlspecialchars($username); ?></strong></a></span>
            <a href="index.php?logout=1" class="logout-link">Logout</a>
        </div>
    </nav>
    
    <div class="dashboard-wrapper">
        <aside class="sidebar">
            <ul class="nav-links">
                <li><a href="dashboard.php">Dashboard Overview</a></li>
                <li><a href="playerDatabase.php" class="active">Player Management</a></li>
                <li><a href="#">Team Search</a></li>
                <li><a href="manageOffers.php">Manage Offers</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <div class="welcome-header">
                <h1>Player Management</h1>
                <p>Manage your player information and details.</p>
            </div>
            <section class="activity-section">
                <h2>Player Information</h2>
                <?php
                $userID = $_SESSION['userID'];

                $positions = [
                    "K"  => "Kicker",
                    "QB" => "Quarterback",
                    "WR" => "Wide Receiver",
                    "RB" => "Running Back",
                    "LB" => "Linebacker",
                    "S"  => "Safety"
                ];

                $myPlayer = getUserPlayers($userID);
                $position = $positions[$myPlayer['position']];
                $position_table = str_replace(' ', '_', $position);

                echo "<div class='player-card'>";
                echo "<h3>" . htmlspecialchars($myPlayer['name']) . "</h3>";
                echo "<p><strong>Position:</strong> " . htmlspecialchars($myPlayer['position']) . "</p>";
                echo "<p><strong>Team:</strong> " . htmlspecialchars(getPlayerTeamName($myPlayer['playerID'])['name']) . "</p>";
                echo "<p><strong>Valuation:</strong> " . number_format($myPlayer['valuation'], 0, '.', ',') . "</p>";                    
                echo "</div>";
                ?>
                <?php if (hasTeam($myPlayer['playerID'])): ?>
                <form method="post" action="index.php">
                <button type="submit" name="LeaveTeam" style="margin-top: 20px; background-color: #e11d48; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 4px; cursor: pointer; font-weight: 600;">Leave Team</button>
            </form>
            <?php endif; ?>
                </section>
                
        </main>
    </div>
</body>
</html>