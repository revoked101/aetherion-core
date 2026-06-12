import { Component, OnInit, OnDestroy } from '@angular/core';
import { createQuantumSignal } from './signal_core.js';
@Component({
  selector: 'aetherion-ui-root',
  template: `<div class="aetherion-dashboard-frame"><h2>⚛️ AETHERION ADVANCED UI TELEMETRY</h2><p>Sovereign Architect: Mandlenkosi Vundla</p><div class="matrix-grid"><div class="card"><h3>📊 ENGINES</h3><div class="metric-line">Quantum: {{quantumLoad}}</div><div class="metric-line">Classical: {{classicalLoad}}</div><div class="metric-line">Sync: <span class="latency-overlay">{{latencyOverlay}}</span></div></div><div class="card"><h3>🛡️ SECURITY MESH</h3><div class="metric-line">Vault Lease: {{vaultStatus}}</div><div class="metric-line">WireGuard Mesh: ACTIVE [3 Peers]</div></div></div><div class="matrix-grid"><div class="card" style="grid-column: span 2;"><h3>🧬 MOLECULAR VIEWPORT</h3><div class="metric-line">State: {{molecularState}}</div><div class="webgl-canvas-stub">[WebGL Accelerated GPU Context]</div></div></div></div>`,
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit, OnDestroy {
  public quantumLoad=''; public classicalLoad=''; public latencyOverlay=''; public vaultStatus=''; public molecularState='';
  private qSig = createQuantumSignal('4096 Qubits Active [Lattice Persistent]');
  private cSig = createQuantumSignal('Brute Force Vector Cluster Capacity Optimized');
  private lSig = createQuantumSignal('0.000 ps Monotonic Delta Stable');
  private vSig = createQuantumSignal('Token Active [Auto-Rotating 3600s]');
  private mSig = createQuantumSignal('Protein Topology Array Mapping Active');
  private unsubs: Function[] = [];
  ngOnInit() {
    this.unsubs.push(this.qSig.subscribe(v => this.quantumLoad = v));
    this.unsubs.push(this.cSig.subscribe(v => this.classicalLoad = v));
    this.unsubs.push(this.lSig.subscribe(v => this.latencyOverlay = v));
    this.unsubs.push(this.vSig.subscribe(v => this.vaultStatus = v));
    this.unsubs.push(this.mSig.subscribe(v => this.molecularState = v));
  }
  ngOnDestroy() { this.unsubs.forEach(f => f()); }
}
