# Template

A starting point for new macOS and iOS apps. The app targets are thin shells — each is a single `App.swift` plus resources — and all real code lives in two local Swift packages: `ProjectKit` for UI and `ProjectCore` for pure logic.

## After cloning

    gh repo create hungryfoolishwork/someapp --template hungryfoolishwork/template --private --clone
    cd someapp
    make rename NAME=SomeApp

## Rewriting this README

This README describes the template, not your project. Once the rename is done, rewrite it. Replace the title, the lead paragraph, and everything above this line with a real description of the project, and delete this section. The rewrite should answer:

- What does the app do, and for whom? One or two plain paragraphs, no marketing voice.
- What are the core concepts or nouns of the app, and what does each mean? One short section per concept.
- What state is the project in — working, prototype, pre-anything? Say so honestly.
