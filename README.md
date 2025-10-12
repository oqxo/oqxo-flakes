# Using oqxo-flakes in your project


```

{
  description = "Example flake using oqxo-flakes";

  inputs.oqxo.url = "github:oqxo/oqxo-flakes/1.0"; 

  outputs = { self, oqxo, nixpkgs }: {
    devShells.x86_64-linux.default = oqxo.devShells.x86_64-linux.java8;
  };
}
```
