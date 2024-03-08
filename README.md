docker-snapcast-server
======================

<p align="center">
    <a href="https://github.com/PHLAK/docker-snapcast-server/discussions"><img src="https://img.shields.io/badge/Join_the-Community-7b16ff.svg?style=for-the-badge" alt="Join the Community"></a>
    <a href="https://github.com/users/PHLAK/sponsorship"><img src="https://img.shields.io/badge/Become_a-Sponsor-cc4195.svg?style=for-the-badge" alt="Become a Sponsor"></a>
    <a href="https://paypal.me/ChrisKankiewicz"><img src="https://img.shields.io/badge/Make_a-Donation-006bb6.svg?style=for-the-badge" alt="One-time Donation"></a>
    <br>
    <a href="https://hub.docker.com/repository/docker/phlak/snapcast-server/tags"><img alt="Docker Image Version" src="https://img.shields.io/docker/v/phlak/snapcast-server?style=flat-square&sort=semver"></a>
    <a href="https://hub.docker.com/repository/docker/phlak/snapcast-server"><img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/phlak/snapcast-server?style=flat-square"></a>
    <a href="https://github.com/PHLAK/docker-snapcast-server/blob/master/LICENSE"><img src="https://img.shields.io/github/license/PHLAK/docker-snapcast-server?style=flat-square" alt="License"></a>
    <a href="https://hub.docker.com/repository/docker/phlak/snapcast-server/builds"><img alt="Docker Cloud Build Status" src="https://img.shields.io/docker/cloud/build/phlak/snapcast-server?style=flat-square"></a>
</p>

<p align="center">
    Docker image for <a href="https://github.com/badaix/snapcast/">Snapcast</a> server.
</p>

---

Running the Container
---------------------

First create some named data volumes to hold the persistent data:

    docker volume create --name snapcast-config

Then run the Syncthing client:

    docker run -d -p 1704:1704 -p 1704:1704 -p 1780:1780 -v snapcast-config:/etc/snapcast.conf --name snapcast-server phlak/snapcast-server

#### Optional arguments

<dl>
  <dt><code>--restart unless-stopped</code></dt>
  <dd>Always restart the container regardless of the exit status, but do not start it on daemon startup if the container has been put to a stopped state before. See the Docker <a href="https://goo.gl/Y0dlDH">restart policies</a> for additional details.</dd>
</dl>

Troubleshooting
---------------

For general help and support join our [GitHub Discussions](https://github.com/PHLAK/docker-snapcast-server/discussions) or reach out on [Twitter](https://twitter.com/PHLAK).

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-snapcast-server/issues).

Copyright
---------

This project is licensed under the [MIT License](https://github.com/PHLAK/docker-snapcast-server/blob/master/LICENSE).
