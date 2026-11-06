import fs from 'node:fs';
import {execFileSync} from 'node:child_process';
const project='ios/App/App.xcodeproj/project.pbxproj',pods='ios/App/Podfile',plist='ios/App/App/Info.plist';
let p=fs.readFileSync(project,'utf8');if(!/IPHONEOS_DEPLOYMENT_TARGET/.test(p))throw Error('Missing deployment target');
p=p.replace(/IPHONEOS_DEPLOYMENT_TARGET\s*=\s*"?([0-9.]+)"?\s*;/g,(m,v)=>parseInt(v)<15?'IPHONEOS_DEPLOYMENT_TARGET = 15.0;':m);fs.writeFileSync(project,p);
let pod=fs.readFileSync(pods,'utf8');pod=pod.replace(/(platform\s+:ios,\s*['"])([0-9.]+)(['"])/g,(m,a,v,b)=>a+(parseInt(v)<15?'15.0':v)+b);fs.writeFileSync(pods,pod);
function setPlist(key,type,value){try{execFileSync('/usr/libexec/PlistBuddy',['-c',`Set :${key} ${value}`,plist])}catch{execFileSync('/usr/libexec/PlistBuddy',['-c',`Add :${key} ${type} ${value}`,plist])}}
// This preview implements no independent/custom encryption; OS HTTPS remains OS-provided.
setPlist('ITSAppUsesNonExemptEncryption','bool','false');setPlist('UIStatusBarStyle','string','UIStatusBarStyleLightContent');
execFileSync('swift',['scripts/make-icons.swift'],{stdio:'inherit'});

execFileSync('node',['scripts/apply-fabricate-premium.mjs'],{stdio:'inherit'});
