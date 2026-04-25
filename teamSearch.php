<?php
require("transferportaldb.php");
session_start();

if (!isset($_SESSION['user'])) {
    header("Location: login.php");
    exit();
}

$searchQuery = $_GET['search'];
$teams = [];
if (!empty($searchQuery)) {
    $teams = teamSearch($searchQuery);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Team Search - Transfer Portal</title>
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
                <h1>Team Search</h1>
                <p>Find your next team and request to join their roster.</p>
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
                <form method="get" action="teamSearch.php" style="margin-bottom: 2rem; display: flex; gap: 10px;">
                    <input type="text" name="search" placeholder="Enter team name..." value="<?php echo htmlspecialchars($searchQuery); ?>" style="flex: 1; padding: 0.75rem; border: 1px solid #ddd; border-radius: 4px; font-size: 1rem;">
                    <button type="submit" style="background-color: #3498db; color: white; border: none; padding: 0 1.5rem; border-radius: 4px; cursor: pointer; font-weight: 600;">Search</button>
                </form>

                <div class="stats-container">
                    <?php if (empty($teams) && !empty($searchQuery)): ?>
                        <p>No teams found matching "<?php echo htmlspecialchars($searchQuery); ?>"</p>
                    <?php elseif (empty($teams)): ?>
                        <p>Search for a team to see results.</p>
                    <?php else: ?>
                        <?php foreach ($teams as $team): ?>
                            <a href="teamInfo.php?teamID=<?php echo $team['teamID']; ?>" style="text-decoration: none; color: inherit;">
                                <div class="stat-card" style="transition: transform 0.2s; cursor: pointer;">
                                    <h3><?php echo htmlspecialchars($team['name']); ?></h3>
                                </div>
                            </a>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </div>
            </section>
        </main>
    </div>
</body>
</html>