<?php
require("transferportaldb.php");
session_start();

if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offers - Transfer Portal</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <nav class="top-nav">
        <div class="brand">Fantasy Football Portal</div>
        <div class="user-menu">
            <span>Welcome, <a href="profile.php" style="text-decoration: none; color: inherit;"><strong><?php echo htmlspecialchars($_SESSION['user']); ?></strong></a></span>
            <a href="index.php?logout=1" class="logout-link">Logout</a>
        </div>
    </nav>
    
    <div class="dashboard-wrapper">
        <aside class="sidebar">
            <ul class="nav-links">
                <li><a href="dashboard.php">Dashboard Overview</a></li>
                <li><a href="playerManagement.php">Player Management</a></li>
                <li><a href="#">Team Management</a></li>
                <li><a href="#">Recruitment Offers</a></li>
                <li><a href="manageOffers.php" class="active">Manage Offers</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <div class="welcome-header">
                <h1>Offers Dashboard</h1>
                <p>Manage your offers from here.</p>
            </div>
            
            <div class="stats-container">
                <?php
                $userID = $_SESSION['userID'];
                $playerID = getUserPlayers($userID)['playerID'];
                ?>
                <?php echo "<div class='stat-card'><h3>Total Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID)) . "</div></div>"; ?>
                <?php echo "<div class='stat-card'><h3>Pending Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID, 'Pending')) . "</div></div>"; ?>
                <?php echo "<div class='stat-card'><h3>Accepted Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID, 'Accepted')) . "</div></div>"; ?>
                <?php echo "<div class='stat-card'><h3>Rejected Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID, 'Rejected')) . "</div></div>"; ?>
            </div>
            
            <section class="activity-section">
                <h2>Manage Offers</h2>
                <?php  
                $offers = getOffersByPlayer($playerID);
                foreach($offers as $offer) {
                    $team = getTeamByID(getOfferTeamByCoach($offer['coachID'])['teamID']);
                    echo "<div class='offer-card'>";
                    echo "<h3>" . "Team: " . htmlspecialchars($team['name']) . "</h3>";
                    echo "<p><strong>Status:</strong> " . htmlspecialchars($offer['status']) . "</p>";
                    echo "<p><strong>Valuation:</strong> $" . number_format($offer['valuation'], 0, '.', ',') . "</p>";
                    echo "</div>";
                    echo "<hr>";
                }
                ?>
            </section>
        </main>
    </div>
</body>
</html>