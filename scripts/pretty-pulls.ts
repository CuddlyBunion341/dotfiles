#!/usr/bin/env bun

/*
Example usage:

curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(echo $GITHUB_REST_TOKEN)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/renuo/khw2/pulls\?state=all | ./pretty-pulls.ts > file.html && open file.html
*/

let data = '';

process.stdin.resume();
process.stdin.setEncoding('utf8');

process.stdin.on('data', (chunk) => {
  data += chunk;
});

type PullRequest = {
  html_url: string
  number: number
  title: string
  user: { login: string }
}

const prs: { username: string, url: string, number: number, title: string }[] = []

process.stdin.on('end', () => {
  try {
    const pulls = JSON.parse(data) as PullRequest[]
    pulls.forEach(pull => {
      const { title, number, html_url, user } = pull
      prs.push({ title, number, url: html_url, username: user.login })
    })

    console.log(`
<!DOCTYPE html>
<html>
<body>
<table>
<tr>
${prs.map(pr => {)
      }.join('')
</tr>
${prs.map(pr => {
        return `<tr>
<!--
<td><a href="${pr.url}">${pr.title}</a></td>
<td>${pr.username}</td>
-->
<td><a href="${pr.url}">#${pr.number}</a></td>
</tr>`}).join('')}
</table>
</body>
</html>
`)
  } catch (e) {
    console.error(e);
  }
})

