<?
if ($_SERVER['REQUEST_METHOD'] === 'POST')
{
  $file = '/tmp/sample-app.log';
  $message = file_get_contents('php://input');
  file_put_contents($file, date('Y-m-d H:i:s') . " Received message: " . $message . "\n", FILE_APPEND);
}
else
{
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>My PHP Application</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lobster+Two" type="text/css">
    <link rel="icon" href="https://awsmedia.s3.amazonaws.com/favicon.ico" type="image/ico" >
    <link rel="shortcut icon" href="https://awsmedia.s3.amazonaws.com/favicon.ico" type="image/ico" >
    <!--[if IE]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <link rel="stylesheet" href="/styles.css" type="text/css">
</head>
<body>
    <section class="congratulations">
        <h1>Congratulations!!! <br>The project was <br> successfully deployed <br><br> test created by Ivan Mospan</h1>

    </section>

    <section class="instructions">
        <h2>What was done?</h2>
        <ul>
            <li>A virtual machines were deployed on AWS by Terraform</li>
            <li>An Ansible playbook has been created with roles to install and configure Jenkins and plugins</li>
            <li>A Jenkins file that manages the Multibranch pipeline script has been created and uploaded to Github</li>
            <li>A Jenkins project has been created with the trigger specified for changes in the git repository</li>
            <li>Telegram notifications were configured</li>
        </ul>

        <h2>In addition:</h2>
        <ul>
            <li>An application has been created on Elastic Beanstalk</li>
            <li>A Jenkins project is set up to deploy the code to Elastic Beanstalk after it was tested</li>
            <li>Telegram notifications were configured for successful project deployment</li>
        </ul>
    </section>

    <!--[if lt IE 9]><script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script><![endif]-->
</body>
</html>
<? 
} 
?>
