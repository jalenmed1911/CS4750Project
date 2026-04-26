<?php
require("transferportaldb.php");
session_start();

if (!isset($_SESSION['user'])) {
    header("Location: login.php");
    exit();
}

$teamID = $_GET['teamID'] ?? null;
if (!$teamID) {
    header("Location: teamSearch.php");
    exit();
}

$team = getTeamByID($teamID);
if (!$team) {
    header("Location: teamSearch.php");
    exit();
}

$coach = getCoachByTeam($teamID);
$players = getPlayersByTeam($teamID);

$valuation = 0;

foreach ($players as $p){
    $valuation += $p['valuation'];
}
$valuation = number_format($valuation / count($players), 1);

$isAlreadyOnThisTeam = false;
if ($_SESSION['role'] === 'user') {
    $userPlayer = getUserPlayers($_SESSION['userID']);
    $playerTeam = $userPlayer ? getPlayerTeamName($userPlayer['playerID']) : null;
    $isAlreadyOnThisTeam = ($playerTeam && $playerTeam['name'] === $team['name']);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($team['name']); ?> - Transfer Portal</title>
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
                <?php
                if ($_SESSION['role'] == 'admin') {
                    echo "<li><a href='dashboard.php'>Admin Dashboard</a></li>";
                } else {
                    echo "<li><a href='playerManagement.php'>Dashboard</a></li>";
                }
                ?>
                <li><a href="teamSearch.php" class="active">Team Search</a></li>
                <li><a href="manageOffers.php">Manage Offers</a></li>
            </ul>
        </aside>
        <main class="main-content">
            <div class="welcome-header">
                <h1><?php echo htmlspecialchars($team['name']); ?></h1>
                <p>Team Information and Roster</p>
            </div>

            <div class="stats-container">
                <div class="stat-card">
                    <h3>Head Coach</h3>
                    <div class="value"><?php echo htmlspecialchars($coach['name']); ?></div>
                </div>
                <div class="stat-card">
                    <h3>Roster Size</h3>
                    <div class="value"><?php echo count($players); ?> Players</div>
                </div>
                <div class="stat-card">
                    <h3>Avg Team Valuation</h3>
                    <div class="value"><?php echo $valuation; ?></div>
                </div>
            </div>

            <section class="activity-section">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <h2>Roster</h2>
                    <?php if ($_SESSION['role'] !== 'admin' && !$isAlreadyOnThisTeam): ?>
                        <form method="post" action="index.php" onsubmit="return confirm('Send a request to join this team?');">
                            <input type="hidden" name="teamID" value="<?php echo htmlspecialchars($teamID); ?>">
                            <button type="submit" name="JoinRequest" style="background-color: #3498db; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 4px; cursor: pointer; font-weight: 600;">Request to Join Team</button>
                        </form>
                    <?php endif; ?>
                </div>

                <div style="background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead style="background-color: #f8fafc; border-bottom: 2px solid #edf2f7;">
                            <tr>
                                <th style="padding: 1rem;">Player Name</th>
                                <th style="padding: 1rem;">Position</th>
                                <th style="padding: 1rem;">Valuation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($players as $p): ?>
                            <tr style="border-bottom: 1px solid #edf2f7;">
                                <td style="padding: 1rem;"><?php echo htmlspecialchars($p['name']); ?></td>
                                <td style="padding: 1rem;"><?php echo htmlspecialchars($p['position']); ?></td>
                                <td style="padding: 1rem;"><?php echo number_format($p['valuation'], 0); ?></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</body>
</html>