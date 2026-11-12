<h1 align="center">
  <a href="https://github.com/posquit0/Awesome-CV" title="AwesomeCV Documentation">
    <img alt="AwesomeCV" src="https://github.com/posquit0/Awesome-CV/raw/master/icon.png" width="200px" height="200px" />
  </a>
  <br />
  Awesome CV
</h1>

<p align="center">
  LaTeX template for your outstanding job application
</p>

<div align="center">
  <img alt="Resume" src="https://img.shields.io/badge/platform-any-mediumslateblue.svg?style=for-the-badge&logoColor=white&logo=OpenContainersInitiative" />
  <img alt="Resume" src="https://img.shields.io/badge/📄%20resume-pdf-green.svg?style=for-the-badge" />
  <img alt="Cover Letter" src="https://img.shields.io/badge/📄%20coverletter-pdf-green.svg?style=for-the-badge" />
  <a href="https://www.buymeacoffee.com/ra101">
    <img alt="Donate" src="https://img.shields.io/badge/Donate-❤️-pink.svg?style=for-the-badge&logoColor=white&logo=buymeacoffee" />
  </a>
</div>

<br />

## What is Awesome CV?

**Awesome CV** is LaTeX template for a **Résumé** and/or **Cover Letter** inspired by [Fancy CV](https://www.sharelatex.com/templates/cv-or-resume/fancy-cv). It is easy to customize your own template, especially since it is really written by a clean, semantic markup.

This project is a Dockerized fork of [Awesome-CV](https://github.com/posquit0/Awesome-CV), customized for my own (although customizable) résumé and cover letter content, build workflow, and contact details.

## Preview

| Résumé | Cover Letter |
| :---: | :---: |
| [![Résumé preview](.assets/resume.png)](.assets/resume.png) | [![Cover letter preview](.assets/coverletter.png)](.assets/coverletter.png) |

## How to Use

#### Requirements

- Podman or Docker installed and running on your machine
- `just` or `make` available in your shell environment

#### Usage

From the project root, run either of the following:

```bash
# Generate both outputs
just all || make all

# Generate one output at a time
just resume || make resume
just coverletter || make coverletter

# Clean generated artifacts
just clean || make clean
```

This should result in the creation of `.pdf` and `.png` for **cover letter** and/or **resume** inside the `output/` directory.


<br>

## 🌟Credit/Acknowledgment

[**posquit0**](https://github.com/posquit0) and [**OJFord**](https://github.com/OJFord) are the awesome developers that maintains the original project.

[**LaTeX**](https://www.latex-project.org) is a fantastic typesetting program that a lot of people use these days, especially the math and computer science people in academia.

[**FontAwesome6 LaTeX Package**](https://github.com/braniii/fontawesome) is a LaTeX package that provides access to the [Font Awesome 6](https://fontawesome.com/v6/icons) icon set.

[**Roboto**](https://github.com/google/roboto) is the default font on Android and ChromeOS, and the recommended font for Google’s visual language, Material Design.

[**Source Sans Pro**](https://github.com/adobe-fonts/source-sans-pro) is a set of OpenType fonts that have been designed to work well in user interface (UI) environments.

<br>

## 📜License

[![License](https://img.shields.io/github/license/ra101/Awesome-CV?style=for-the-badge)](https://github.com/ra101/Awesome-CV/blob/core/LICENSE)

<br>

## 🤙Contact Me

[![Protonmail](https://img.shields.io/badge/Protonmail-Email-ab44fe?style=for-the-badge&logo=protonmail)](mailto://ping@ra101.dev) [![Telegram](https://img.shields.io/badge/Telegram-Chat-informational?style=for-the-badge&logo=telegram)](https://telegram.me/ra_101)
