```
Users/zeynepenkavi % docker images
REPOSITORY       TAG       IMAGE ID       CREATED         SIZE
rocker/rstudio   4.3.0     f327464013aa   5 hours ago     1.89GB
amazon/aws-cli   latest    a7140351dd68   2 days ago      377MB
amazon/aws-cli   <none>    533220ba68fd   21 months ago   326MB
/Users/zeynepenkavi % IMAGE_ID=533220ba68fd
/Users/zeynepenkavi % docker image inspect --format '{{json .}}' "$IMAGE_ID" | jq -r '. | {Id: .Id, Digest: .Digest, RepoDigests: .RepoDigests, Labels: .Config.Labels}'
{
  "Id": "sha256:533220ba68fd874e2201d73684efca5f4a4b38cccdb329ea31ce06f1909dd424",
  "Digest": null,
  "RepoDigests": [
    "amazon/aws-cli@sha256:488f27c19e1acb098a3eef27818102ebe510ec44f454fbfde9b7887a448b763d"
  ],
  "Labels": null
}
/Users/zeynepenkavi % docker manifest inspect amazon/aws-cli@sha256:488f27c19e1acb098a3eef27818102ebe510ec44f454fbfde9b7887a448b763d
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.list.v2+json",
   "manifests": [
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 1366,
         "digest": "sha256:83a68663a9c20b7abef995590f00113bdc0cd9f78032315dcd2b81a0bda87b28",
         "platform": {
            "architecture": "amd64",
            "os": "linux"
         }
      },
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 1366,
         "digest": "sha256:5a261ffae1507a1099248ddefb392b6441084657c23d466a5f211d76953efffa",
         "platform": {
            "architecture": "arm64",
            "os": "linux"
         }
      }
   ]
}
```