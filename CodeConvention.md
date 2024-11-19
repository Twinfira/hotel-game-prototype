# Code Convention 

- [Scripts](#scripts)
- [ClassName](#classname)
- [Variables](#variables)
- [Functions](#functions)

## Scripts
- Scripts are written in Snake Case.

**Correct**
```
attack_script.gd
```
**Incorrect**
```
AttackScript.gd
```
  
## ClassName
  Using a classname, you can make the script globally accessible.
  Classnames are written in Pascal Case
  
  **Correct**
  ```gdscript
  class_name Attack
  ```
  **Incorrect**
  ```gdscript
  class_name attack
  ```

## Variables
- Variables require the type definition. Without this, the code will run significantly slower!
- Variables are written in Snake Case
  
 **Correct**
  ```gdscript
  var attack_damage : float
  ```
  **Correct**
  ```gdscript
  var attack_damage := x
  ```
  **Incorrect**
  ```gdscript
  var attack_damage = x
  ```

## Functions
  Functions, just like variables need type definitions. They are also written in Snake Case
  Functions with the _ prefix, are godot functions. The functions written by us, will not have a prefix of _
  
  **Correct**
  ```gdscript
  func player_attack(damage : int) : void:
  ```
  **Incorrect**
  ```gdscript
  func PlayerAttack(damage):
  ```
