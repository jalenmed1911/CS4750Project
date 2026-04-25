<?php
session_start();
require("transferportaldb.php");
require("positionStats.php");

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
                <?php
                if ($_SESSION['role'] == 'admin') {
                    echo "<li><a href='dashboard.php' class='active'>Admin Dashboard</a></li>";
                } else {
                    echo "<li><a href='playerManagement.php' class='active'>Dashboard</a></li>";
                }
                ?>
                <li><a href="teamSearch.php">Team Search</a></li>
                <li><a href="manageOffers.php">Manage Offers</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <div class="welcome-header">
                <h1>Player Dashboard</h1>
                <p>Manage your player information.</p>
            </div>

            <?php if (isset($_SESSION['error'])): ?>
                <div style="background: #fee2e2; color: #991b1b; padding: 1rem; border-radius: 6px; margin-bottom: 1.5rem; border: 1px solid #fecaca;">
                    <?php echo htmlspecialchars($_SESSION['error']); unset($_SESSION['error']); ?>
                </div>
            <?php endif; ?>

            <?php if (isset($_SESSION['success'])): ?>
                <div style="background: #ecfdf5; color: #065f46; padding: 1rem; border-radius: 6px; margin-bottom: 1.5rem; border: 1px solid #a7f3d0;">
                    <?php echo htmlspecialchars($_SESSION['success']); unset($_SESSION['success']); ?>
                </div>
            <?php endif; ?>

            <section class="activity-section">
                <h2>Player Information</h2>
                <?php
                $userID = $_SESSION['userID'];

                $myPlayer = getUserPlayers($userID);
                $pos_abbr = $myPlayer['position'];
                $config = $positionStats[$pos_abbr];
                $pos_full = $config['table'];
                $statsMap = $config['stats'];

                echo "<div class='player-card'>";
                echo "<h3>" . htmlspecialchars($myPlayer['name']) . "</h3>";
                echo "<p><strong>Position:</strong> " . htmlspecialchars(str_replace('_', ' ', $pos_full)) . "</p>";
                echo "<p><strong>Team:</strong> " . (hasTeam($myPlayer['playerID']) ? htmlspecialchars(getPlayerTeamName($myPlayer['playerID'])['name']) : "Free Agent") . "</p>";
                echo "<p><strong>Valuation:</strong> " . number_format($myPlayer['valuation'], 0, '.', ',') . "</p>";                    
                echo "<p><strong>Stars:</strong> " . number_format($myPlayer['stars'], 0, '.', ',') . "</p>";                    
                echo "</div>";
                ?>
                <?php if (hasTeam($myPlayer['playerID'])): ?>
                <form method="post" action="index.php">
                <button type="submit" name="LeaveTeam" style="margin-top: 20px; background-color: #e11d48; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 4px; cursor: pointer; font-weight: 600;">Leave Team</button>
                </form>
                <?php endif; ?>

                <?php
                $stats = getStatsByPlayer($myPlayer['playerID']);

                if (!$stats) {
                    echo "No stats found.";
                    return;
                }

                $pos = $stats['position']; // "QB", "RB", etc.
                $config = $positionStats[$pos];

                foreach ($config['stats'] as $column => $label) {
                    echo "<p><strong>$label:</strong> " . htmlspecialchars($stats[$column]) . "</p>";
                }
                ?>

                </section>
                
        </main>
    </div>
</body>
</html>