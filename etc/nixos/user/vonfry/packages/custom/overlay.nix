self: super:

let export = import ./.; in
with self;
{
  vonfryPython = export.vonfryPython.override { python = python3 }
}
